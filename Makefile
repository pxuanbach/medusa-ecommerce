build-be:
	docker build -t pxuanbach/medusa-backend ./backend

build-be-prod:
	docker build -t pxuanbach/medusa-backend:prod ./backend -f Dockerfile.prod

build-ad-prod:
	docker build -t pxuanbach/medusa-backend-admin:prod ./backend -f Dockerfile.admin.prod

build-fe:
	docker build -t pxuanbach/medusa-storefront ./storefront

build-fe-prod:
	docker build -t pxuanbach/medusa-storefront:prod ./storefront -f Dockerfile.prod

push-fe:
	docker push pxuanbach/medusa-storefront --all-tags

push-be:
	docker push pxuanbach/medusa-backend --all-tags

push-ad:
	docker push pxuanbach/medusa-backend-admin --all-tags


up:
	docker compose down && docker compose up -d

up-prod:
	docker compose -f docker-compose.prod.yml down && docker compose -f docker-compose.prod.yml up -d

down:
	docker compose down

down-v:
	docker compose down -v

seed:
	docker compose exec backend yarn seed