Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2004 15:44:35 +0100 (BST)
Received: from mailout02.sul.t-online.com ([IPv6:::ffff:194.25.134.17]:5260
	"EHLO mailout02.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225009AbUJWOoa>; Sat, 23 Oct 2004 15:44:30 +0100
Received: from fwd09.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1CLN87-0006zD-04; Sat, 23 Oct 2004 16:44:27 +0200
Received: from null (VrzxyEZUoevzQUUMlyo63mDWm8v9IALMh61VZ30dU8QT5y5vTwNw8F@[217.81.125.5]) by fwd09.sul.t-online.com
	with esmtp id 1CLN83-0JLTKi0; Sat, 23 Oct 2004 16:44:23 +0200
From: 520066427640-0001@t-online.de (Bruno Randolf)
To: linux-mips@linux-mips.org
Subject: Re: Hi-Speed USB controller and au1500
Date: Sat, 23 Oct 2004 16:38:15 +0200
User-Agent: KMail/1.7
References: <CECB0B0453C6D511BEB800104B70FA47B4A025@STARBASE>
In-Reply-To: <CECB0B0453C6D511BEB800104B70FA47B4A025@STARBASE>
Organization: 4G Systems
Cc: "'Eric DeVolder'" <eric.devolder@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3540544.GLSJJmDHZk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410231638.20982.bruno.randolf@4g-systems.biz>
X-ID: VrzxyEZUoevzQUUMlyo63mDWm8v9IALMh61VZ30dU8QT5y5vTwNw8F
X-TOI-MSGID: 3ba06dc8-44ec-49eb-b3d1-c15eec2c957f
Return-Path: <520066427640-0001@t-online.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 520066427640-0001@t-online.de
Precedence: bulk
X-list: linux-mips

--nextPart3540544.GLSJJmDHZk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

maybe not everything ist fixed in AD stepping... we have observed that on o=
ur=20
Au1500 AD board the internal USB host only works when we set=20
CONFIG_NONCOHERENT_IO=3Dy.=20

without CONFIG_NONCOHERENT_IO=3Dy we get crashes when the used usb bandwidt=
h=20
gets higher. for example with an USB ethernet adapter: ping works but real=
=20
traffic makes the kernel crash. usb-storage does not work at all.

can you confirm this?

would it be possible to use CONFIG_NONCOHERENT_IO=3Dy only for USB, and not=
 PCI?=20
we have PCI cards (prism54) which only work without CONFIG_NONCOHERENT_IO, =
so=20
at the moment we can either have USB host or prism54 based PCI cards...

bruno





On Friday 22 October 2004 16:15, Yates, John wrote:
> Thank you. This indeed works.
>
> The CONFIG_NONCOHERENT_IO option is set by default in config-shared.in wh=
en
> one selects the db1500 board (among others). Does anyone have
> recommendations as to how to modify config-shared.in to give others the
> option of disabling this default behavior?
>
> Possible places could be:
>
> 1. Add an override defaults sub-menu for the boards that support disabling
> CONFIG_NONCOHERENT_IO.
>
> 2. Add a CONFIG_NONCOHERENT_IO item to the bottom of "Machine Selection"
> menu. (There is already a "High Memory Support" option at the bottom of t=
he
> "machine Selection" menu.)
>
> 3. Add a CONFIG_NONCOHERENT_IO item to the "Override CPU options" sub-menu
> (in the "CPU Selection" menu).
>
> 4....
>
> Thanks, John
>
> -----Original Message-----
> From: Eric DeVolder [mailto:eric.devolder@amd.com]
> Sent: Monday, October 18, 2004 12:28 PM
> To: Yates, John
> Subject: Re: Hi-Speed USB controller and au1500
>
> I'm guessing that CONFIG_NONCOHERENT_IO is set which means that the
> buffers used by USB are non-cached, and so the LL/SC combinations
> performed by the USB stack to the structs in this non-cached area will
> always fail. (Examine the MIPS LL/SC...only works to cached spaces...)
>
> Depending upon which version of the Au1500 you have,
> CONFIG_NONCOHERENT_IO was necessary due to coherency bugs. I believe
> everything should be fixed with Au1500 AD so that CONFIG_NONCOHERENT_IO
> isn't needed....
>
> Eric
>
> Yates, John wrote:
> >Hello all,
> >
> >I am having a problem using a PCI USB 2.0 Hi-Speed controller (EHCI) with
> >the dbau1500 eval kit with kernel 2.4.26. I have traced the problem down
> > to a call to atomic_add() (in include/asm-mips/atomic.h) that uses
> > assembly to access ll/sc registers of the mips architecture.  If I
> > override CPU options and disable ll/sc when configuring the kernel,=20
> > everything works fine. However this causes the atomic_add() to use
> >local_irq_save()/local_irq_restore().  I am assuming this will cause qui=
te
>
> a
>
> >performance hit since atomic_add() gets called all over the place.  I
>
> should
>
> >include that the ll/sc version of atomic_add() seems to work fine until
> > the call from the usb infrastructure.
> >
> >Below is a code trail that leads to the call to atomic_add():
> >
> >
> >hub.c:   usb_hub_port_connect_change()
> >usb.c:    usb_set_address()
> >usb.c:    usb_control_msg()
> >usb.c:    usb_internal_control_msg()
> >usb.c:    usb_start_wait_urb()
> >usb.c:    usb_submit_urb()
> >usb.c:    submit_urb()
> >hcd.c:    hcd_submit_urb()
> >host/ehci-hcd.c:   ehci_urb_enqueue()  (urb_enqueue
> >function ptr)
> >host/ehci-q.c:   submit_async()
> >host/ehci-q.c:   qh_append_tds()
> >host/ehci-mem.c:   qh_get()
> >atomic.h   atomic_inc()
> >atomic.h   #define atomic_inc(v) atomic_add(1,(v)) <-
> >uses ll/sc
> >
> >To reproduce my results:
> >
> >Plug in a Hi-Speed USB 2.0 controller into your pci slot and boot with a
>
> usb
>
> >ehci enabled  kernel. Be sure to disable the non-pci usb host that is
> >built-in to the au1500 when building the  kernel. (I have tried two
> >controllers (NEC and ALi) with identical results.)
> >
> >Plug a Hi-Speed device (thumb drive or external HD) into the controller.
> >(system stops responding here)
> >
> >Low/Full speed devices work without a problem because they use the ohci =
or
> >uhci drivers.
> >
> >
> >Any help or direction will be greatly appreciated.
> >
> >John

--nextPart3540544.GLSJJmDHZk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBemzcfg2jtUL97G4RAjaJAKCKk4s72Ns8r0S4tNKjNeYy6xKlMwCgrBzw
UqukiZkGudJ9iCvRhlHlqG0=
=LjVV
-----END PGP SIGNATURE-----

--nextPart3540544.GLSJJmDHZk--
