Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2008 10:35:13 +0100 (BST)
Received: from moutng.kundenserver.de ([212.227.126.187]:56831 "EHLO
	moutng.kundenserver.de") by ftp.linux-mips.org with ESMTP
	id S20805187AbYJGJfG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2008 10:35:06 +0100
Received: from dyn-9-152-242-93.boeblingen.de.ibm.com (blueice2n1.de.ibm.com [195.212.29.171])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1Kn8y014Tn-0005at; Tue, 07 Oct 2008 11:34:58 +0200
From:	Arnd Bergmann <arnd@arndb.de>
To:	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] serial: Add Cavium OCTEON UART definitions.
Date:	Tue, 7 Oct 2008 11:34:50 +0200
User-Agent: KMail/1.9.9
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
References: <48EAAF97.8050307@caviumnetworks.com>
In-Reply-To: <48EAAF97.8050307@caviumnetworks.com>
X-Face:	I@=L^?./?$U,EK.)V[4*>`zSqm0>65YtkOe>TFD'!aw?7OVv#~5xd\s,[~w]-J!)|%=]>=?utf-8?q?+=0A=09=7EohchhkRGW=3F=7C6=5FqTmkd=5Ft=3FLZC=23Q-=60=2E=60Y=2Ea=5E?=
 =?utf-8?q?3zb?=)
 =?utf-8?q?+U-JVN=5DWT=25cw=23=5BYo0=267C=26bL12wWGlZi=0A=09=7EJ=3B=5Cwg?=
 =?utf-8?q?=3B3zRnz?=,J"CT_)=\H'1/{?SR7GDu?WIopm.HaBG=QYj"NZD_[zrM\Gip^U
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200810071134.51012.arnd@arndb.de>
X-Provags-ID: V01U2FsdGVkX18ivyuZfDOfUNJNtIs9h171pghPyvqFlgL4HmI
 M2cswulNAxLHHoY2bN1vFFCS8qFuMOeXDIFdA/xvvywVA2+43q
 VeSUJK8l2Pjca+62rnZKQ==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips

On Tuesday 07 October 2008, David Daney wrote:
> 
> -       up->port.type = PORT_16550A;
> +#ifdef CONFIG_CPU_CAVIUM_OCTEON
> +       /* UPF_FIXED_PORT indicates an internal UART.  */
> +       if (up->port.flags & UPF_FIXED_PORT)
> +               up->port.type = PORT_OCTEON;
> +       else
> +#endif
> +               up->port.type = PORT_16550A;
> +

This looks somewhat wrong, IMHO a device driver should not assume that
a CONFIG_CPU_* symbol is exclusive. You could have (maybe not now, but
in the future) a kernel that supports running on an Octeon as well
as some other Mips64 processor, and have UPF_FIXED_PORT uart on some
other machine, which will make the kernel think it is a PORT_OCTEON.

	Arnd <><
