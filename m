Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 19:04:16 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:64273
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225319AbUEPSEP>; Sun, 16 May 2004 19:04:15 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id 5A6AF38212C; Sun, 16 May 2004 19:04:14 +0100 (BST)
Date: Sun, 16 May 2004 19:04:14 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040516180414.GA15001@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk> <20040516113622.GA14049@getyour.pawsoff.org> <20040516152113.GA9390@convergence.de> <20040516170445.GA4793@linux-mips.org> <20040516172143.GA9753@convergence.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20040516172143.GA9753@convergence.de>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 16, 2004 at 07:21:43PM +0200, Johannes Stezenbach wrote:

> > >  23:     100002            MIPS  eth1
>=20
> 100002 is just where note_interrupt() disables an unhandled irq, so
> maybe Kieran's report that the tulip card works was wrong?
>=20

yup. please excuse me, i was obviously typing out of my arse (or not=20
testing 'thoroughly' enough ...). anyway, the following turns up on=20
running 'dhcpcd eth1' (tulip card in pci slot);

ksymoops 2.4.9 on mips 2.6.6-mipscvs-20040510.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6-mipscvs-20040510/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: [<80084624>]  [<8008461c>]  [<80084720>]  [<800826d0>] =20
[<80084a78>]  [<80082ec0>]  [<800826d0>]  [<80082ec0>]  [<800ec230>] =20
[<800ac7f4>]  [<800ac6f8>]  [<80084578>]  [<800ac7f4>]  [<80084b18>] =20
[<800826d0>]  [<8012ea48>]  [<80082ec0>]  [<800b179c>]  [<800b1788>] =20
[<800ac7f4>]  [<80085468>]  [<80085480>]  [<c0051270>]  [<80084bec>] =20
[<80082ec0>]  [<c0053db8>]  [<800dcf4c>]  [<801a684c>]  [<801ac4e4>] =20
[<800d7924>]  [<801a85fc>]  [<801a66c0>]  [<801e9ae0>]  [<801e9958>] =20
[<800d7c44>]  [<80091b50>]  [<801ec8c4>]  [<801fd878>]  [<801fd888>] =20
[<8019e27c>]  [<8019e1c4>]  [<8019dc9c>]  [<800ff3bc>]  [<800ff194>] =20
[<8019e4bc>]  [<8008be88>]
[<c0051270>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 80084624 <__report_bad_irq+48/8c>
Trace; 8008461c <__report_bad_irq+40/8c>
Trace; 80084720 <note_interrupt+88/d0>
Trace; 800826d0 <cobalt_irq+150/180>
Trace; 80084a78 <do_IRQ+110/1dc>
Trace; 80082ec0 <ret_from_exception+0/0>
Trace; 800826d0 <cobalt_irq+150/180>
Trace; 80082ec0 <ret_from_exception+0/0>
Trace; 800ec230 <bh_lru_install+180/1a4>
Trace; 800ac7f4 <do_softirq+58/8c>
Trace; 800ac6f8 <__do_softirq+48/ec>
Trace; 80084578 <handle_IRQ_event+6c/d0>
Trace; 800ac7f4 <do_softirq+58/8c>
Trace; 80084b18 <do_IRQ+1b0/1dc>
Trace; 800826d0 <cobalt_irq+150/180>
Trace; 8012ea48 <ext3_getblk+d0/298>
Trace; 80082ec0 <ret_from_exception+0/0>
Trace; 800b179c <update_process_times+40/54>
Trace; 800b1788 <update_process_times+2c/54>
Trace; 800ac7f4 <do_softirq+58/8c>
Trace; 80085468 <setup_irq+134/1b0>
Trace; 80085480 <setup_irq+14c/1b0>
Trace; c0051270 <__crc_bio_map_user+9a864/130ac7>
Trace; 80084bec <request_irq+a8/e4>
Trace; 80082ec0 <ret_from_exception+0/0>
Trace; c0053db8 <__crc_bio_map_user+9d3ac/130ac7>
Trace; 800dcf4c <pte_chain_alloc+a4/c8>
Trace; 801a684c <dev_open+94/138>
Trace; 801ac4e4 <dev_mc_upload+58/64>
Trace; 800d7924 <do_no_page+43c/510>
Trace; 801a85fc <dev_change_flags+70/154>
Trace; 801a66c0 <dev_load+24/a0>
Trace; 801e9ae0 <devinet_ioctl+30c/7cc>
Trace; 801e9958 <devinet_ioctl+184/7cc>
Trace; 800d7c44 <handle_mm_fault+f0/278>
Trace; 80091b50 <do_page_fault+170/370>
Trace; 801ec8c4 <inet_ioctl+8c/e8>
Trace; 801fd878 <packet_ioctl+18c/1b0>
Trace; 801fd888 <packet_ioctl+19c/1b0>
Trace; 8019e27c <__sock_create+1a4/384>
Trace; 8019e1c4 <__sock_create+ec/384>
Trace; 8019dc9c <sock_ioctl+418/464>
Trace; 800ff3bc <sys_ioctl+254/2d8>
Trace; 800ff194 <sys_ioctl+2c/2d8>
Trace; 8019e4bc <sys_socket+24/48>
Trace; 8008be88 <stack_done+24/40>
Trace; c0051270 <__crc_bio_map_user+9a864/130ac7>


2 warnings and 1 error issued.  Results may not be reliable.


regards,
kieran.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp60eOWPbH1PXZ18RAgqNAJ4nbY4SuTLcBdw8C50OO9qyG3O6sgCdEYXa
b31qq1tTUKsmjRiZ0Qzph8U=
=NK/3
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
