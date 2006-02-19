Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 22:24:55 +0000 (GMT)
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:48045 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133603AbWBSWYq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 22:24:46 +0000
Received: (qmail 90525 invoked from network); 19 Feb 2006 22:31:33 -0000
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@70.236.93.169 with login)
  by smtp103.sbc.mail.re2.yahoo.com with SMTP; 19 Feb 2006 22:31:32 -0000
From:	Dmitry Torokhov <dtor_core@ameritech.net>
To:	Martin Michlmayr <tbm@cyrius.com>
Subject: Re: Merging Skylark's IOC3 patch
Date:	Sun, 19 Feb 2006 17:31:30 -0500
User-Agent: KMail/1.9.1
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Stanislaw Skowronek <skylark@linux-mips.org>
References: <20060219211527.GA12848@deprecation.cyrius.com> <20060219215550.GO10266@deprecation.cyrius.com>
In-Reply-To: <20060219215550.GO10266@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602191731.31257.dtor_core@ameritech.net>
Return-Path: <dtor_core@ameritech.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dtor_core@ameritech.net
Precedence: bulk
X-list: linux-mips

On Sunday 19 February 2006 16:55, Martin Michlmayr wrote:
> * Martin Michlmayr <tbm@cyrius.com> [2006-02-19 21:15]:
> > Can you please review and/or merge Skylark's IOC3 patch from
> > ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/linux-mips-2.6.14-ioc3-r26.patch.bz2
> > 
> > From my basic understanding I believe that this patch needs to be split up
> > and submitted to different sub-system maintainers.
> 
> (Dmitry, this is only a RFC for now since the main support patch
> for IOC3 has not been merged yet.)
> 

OK... I have some comments, mostly cosmetic.

> +
> +struct ioc3kbd_data {
> +	struct ioc3_driver_data *idd;
> +	struct serio *kbd,*aux;
> +};

Space after comma please.

> +
> +static int ioc3kbd_write(struct serio *dev, unsigned char val)
> +{
> +	struct ioc3kbd_data *d = (struct ioc3kbd_data *)(dev->port_data);

Unneeded parens...

> +	unsigned mask;
> +	unsigned long timeout=0;

Missing spaces around operators...

> +
> +	mask = (dev==d->aux) ? KM_CSR_M_WRT_PEND : KM_CSR_K_WRT_PEND;

Missing spaces around operators...

> +	while((d->idd->vma->km_csr & mask) && (timeout<1000)) {

Missing a space after operator and unneeded parens again.
 
> +	if(dev==d->aux)
> +		d->idd->vma->m_wd=((unsigned)val)&0x000000ff;
> +	else
> +		d->idd->vma->k_wd=((unsigned)val)&0x000000ff;
> +
> +	if(timeout>=1000)

Missing spaces around operators...

> +
> +static int ioc3kbd_open(struct serio *dev)
> +{
> +	return 0;
> +}
> +
> +static void ioc3kbd_close(struct serio *dev)
> +{
> +}

You don't need to implement dummy functions, serio core can live without
these.

> +
> +static struct ioc3kbd_data * __init ioc3kbd_allocate_port(int idx, struct ioc3_driver_data *idd)
> +{
> +	struct serio *sk, *sa;
> +	struct ioc3kbd_data *d;
> +
> +	sk = kmalloc(sizeof(struct serio), GFP_KERNEL);
> +	sa = kmalloc(sizeof(struct serio), GFP_KERNEL);

kzalloc()? You fill them with 0 later anyway. 

> +	d = kmalloc(sizeof(struct ioc3kbd_data), GFP_KERNEL);
> +	if (sk && sa && d) {
> +		memset(sk, 0, sizeof(struct serio));
> +		sk->id.type = SERIO_8042;
> +		sk->write = ioc3kbd_write;
> +		sk->open = ioc3kbd_open;
> +		sk->close = ioc3kbd_close;
> +		snprintf(sk->name, sizeof(sk->name), "IOC3 keyboard %d", idx);
> +		snprintf(sk->phys, sizeof(sk->phys), "ioc3/serio%dkbd", idx);
> +		sk->port_data = d;
> +		sk->dev.parent = &(idd->pdev->dev);
> +		memset(sa, 0, sizeof(struct serio));
> +		sa->id.type = SERIO_8042;
> +		sa->write = ioc3kbd_write;
> +		sa->open = ioc3kbd_open;
> +		sa->close = ioc3kbd_close;
> +		snprintf(sa->name, sizeof(sa->name), "IOC3 auxiliary %d", idx);
> +		snprintf(sa->phys, sizeof(sa->phys), "ioc3/serio%daux", idx);
> +		sa->port_data = d;
> +		sa->dev.parent = &(idd->pdev->dev);
> +		d->idd = idd;
> +		d->kbd = sk;
> +		d->aux = sa;
> +		return d;
> +	}

Need to free() allocated stuff here in case it was not the first allocation
that failed.

> +	return NULL;
> +}
> +
> +static int ioc3kbd_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)

__devinit perhaps?

> +{
> +	struct ioc3kbd_data *d;
> +	if(idd->class != IOC3_CLASS_BASE_IP30 && idd->class != IOC3_CLASS_CADDUO)
> +		return 1;

Usually failure indicator is negative. Serio core does not really care
but people expect to  see either -ENODEV or at least -1.

> +	d = ioc3kbd_allocate_port(idd->id, idd);
> +	idd->data[is->id] = d;
> +	if(!d)
> +		return 1;
> +	ioc3_enable(is, idd);
> +	serio_register_port(d->kbd);
> +	serio_register_port(d->aux);
> +	return 0;
> +}
> +
> +static int ioc3kbd_remove(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
> +{
> +	struct ioc3kbd_data *d = (struct ioc3kbd_data *)(idd->data[is->id]);
> +	serio_unregister_port(d->kbd);
> +	serio_unregister_port(d->aux);
> +	kfree(d->kbd);
> +	kfree(d->aux);

Double free - serio core frees serio structure once the last reference
is dropped. You are freeing already freed memory here.

> +	kfree(d);
> +	idd->data[is->id] = NULL;
> +	return 0;
> +}
> +
> +static struct ioc3_submodule ioc3kbd_submodule = {
> +	.name = "serio",
> +	.probe = ioc3kbd_probe,
> +	.remove = ioc3kbd_remove,
> +	.irq_mask = SIO_IR_KBD_INT,
> +	.intr = ioc3kbd_intr,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int __init ioc3kbd_init(void)
> +{
> +	ioc3_register_submodule(&ioc3kbd_submodule);

Can this ioc3_... function fail?

-- 
Dmitry
