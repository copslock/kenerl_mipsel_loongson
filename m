Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 22:16:33 +0000 (GMT)
Received: from 12-234-207-60.client.attbi.com ([12.234.207.60]:41093 "HELO
	gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225241AbSLKWQd>; Wed, 11 Dec 2002 22:16:33 +0000
Received: (qmail 7032 invoked by uid 502); 11 Dec 2002 22:16:29 -0000
Date: Wed, 11 Dec 2002 14:16:29 -0800
From: ilya@theIlya.com
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: O2 VICE support
Message-ID: <20021211221629.GP609@gateway.total-knowledge.com>
References: <20021210191120.GE609@gateway.total-knowledge.com> <20021211133831.A19300@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FmdPcZLZZW6lDAYm"
Content-Disposition: inline
In-Reply-To: <20021211133831.A19300@infradead.org>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--FmdPcZLZZW6lDAYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Urgg.  Usually kernel headers aren't supposed to be used in userspace.
> If you want to use a copy anyway it should be done with much less burden
> on the kernel code.
Well, most of manipulation of this device will be done bu user-space
code. Kernel's only job is synchronising access and managing memory.
Thus we would like to keep all definitions in one place.

> > +    if (!filp->private_data) {
> > +	filp->private_data =3D vice_device;
> > +    }
>=20
> filp->private_data can't be set.
???
I can live without using it of course, since it isn't currently possible to=
 have
more then one instance of VICE in same machine, but theoretical possibility=
 does
exist. Where should I pass information about which specific device current
call is?

>=20
> > +ssize_t vice_read(struct file * filp, char *buf, size_t count, loff_t =
* f_pos)
> > +{
> > +    printk(KERN_WARNING
> > +	   "Processing bit streams through reading/writing is not supported y=
et\n");
> > +    return -ENOSYS;
> > +}
> > +
> > +ssize_t vice_write(struct file * filp, const char *buf, size_t count,
> > +	   loff_t * f_pos)
> > +{
> > +    printk(KERN_WARNING
> > +	   "Processing bit streams through reading/writing is not supported (=
yet)\n");
> > +    return -ENOSYS;
> > +}
>=20
> What about just not implementing the methods instead?
This is more like reminder to myself that I should do that one day :)

> > +static void vice_vma_open(struct vm_area_struct *vma)
> > +{ MOD_INC_USE_COUNT; }
> > +
> > +static void vice_vma_close(struct vm_area_struct *vma)
> > +{ MOD_DEC_USE_COUNT; }
>=20
> This is silly.  You get a reference for vma->vm_file as long as you
> have any mmaps.  That's enough for the refcounting.
I was wondering about that too, but this is the way i was in book :)

>=20
> > +static struct vm_operations_struct vice_vm_ops =3D {
> > +    open:  vice_vma_open,
> > +    close: vice_vma_close,
> > +    nopage: vice_vma_nopage,
> > +};
>=20
> Please use C99-initializers (i.e. .foo =3D bar)
>=20
> > +void vice_cleanup_module(void)
> > +{
> > +#ifndef CONFIG_DEVFS_FS
> > +    /* cleanup_module is never called if registering failed */
> > +    unregister_chrdev(vice_major, "vice");
> > +#endif
>=20
> Umm, just because someone makes the mistake of enabling devfs he
> doesn't have to use it.. :)
I'm not buying that one :)

>=20
> > +#ifndef VICE_DEBUG
> > +    EXPORT_NO_SYMBOLS;		/* otherwise, leave global symbols visible */
> > +#endif
>=20
> EXPORT_NO_SYMBOLS is a noop on 2.5
Driver was written for 2.4 first.


Thanks a lot for constructive criticism.

	Ilya.


--FmdPcZLZZW6lDAYm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE997k984S94bALfyURAl61AKDgw5MlLzEIy4yClWMF+DZfj2uy6wCfeQTR
bJuWzyOMNC+nF7gizU7Gpzk=
=FjmJ
-----END PGP SIGNATURE-----

--FmdPcZLZZW6lDAYm--
