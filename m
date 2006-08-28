Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2006 22:16:21 +0100 (BST)
Received: from mail01.hansenet.de ([213.191.73.61]:57501 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20039298AbWH1VQU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Aug 2006 22:16:20 +0100
Received: from [80.171.2.198] (80.171.2.198) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EA7D5F001B9F52; Mon, 28 Aug 2006 23:16:08 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 9FA9B2C412;
	Mon, 28 Aug 2006 23:16:07 +0200 (CEST)
From:	Thomas Koeller <thomas@koeller.dyndns.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Suppress compiler warnings
Date:	Mon, 28 Aug 2006 23:16:07 +0200
User-Agent: KMail/1.9.3
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas =?iso-8859-1?q?K=F6ller?= <thomas.koeller@baslerweb.com>
References: <200608271353.16681.thomas@koeller.dyndns.org> <200608271800.27441.thomas@koeller.dyndns.org> <Pine.LNX.4.62.0608281018050.25303@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0608281018050.25303@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200608282316.07263.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

On Monday 28 August 2006 11:19, Geert Uytterhoeven wrote:
> On Sun, 27 Aug 2006, Thomas Koeller wrote:
> > On Sunday 27 August 2006 14:12, Geert Uytterhoeven wrote:
> > >
> > > How can a driver look them up, if they are not linked in in some
> > > structure?
> >
> > It uses the standard platform device/driver mechanism: the platform
> > registers a platform device (to which the resources are attached) with
> > the platform bus. The driver registers a platform driver with the
> > platform bus. The bus matches drivers and devices and calls the probe
> > routine of any matching driver, at which point the driver can look up the
> > resources using platform_get_resource_byname().
>
> I know that.
>

Sorry, I see that my explanation missed your point.

> I mean, since they are static, no one uses them yet. So each possible
> driver that will want to use them should add some code to this single
> source file?
>

No, just the opposite.

The platform has a set of static 'struct resource' instances that reflect the
actual h/w resources present. Their purpose is to enforce nonconflicting use
of h/w resources. Resources that the platform attaches to platform devices it
creates are allocated from these static structs.

For example, the processor has six h/w counter/timer units, so there is a
'struct resource excite_ctr_resource' ranging from 0 to 5. The platform
wants to create a platform device for a watchdog driver to use, which
(among other things) requires a counter, so it allocates one from the static
resource, and attaches it to the platform device. The watchdog driver can then
retrieve it by its name.

Now, to save some code and data, the allocation described above is only done
if a watchdog driver is actually configured. If not (since the WD currently is
the only driver for an integrated RM9K peripheral that requires a counter), then
the static 'struct resource excite_ctr_resource' becomes unused. I could exclude
it as well in this case, but this would get messy if more drivers requiring
counters were written. In general terms, I could exclude any of the static
resource structs if _no_ driver using this particular kind of resource is
configured, but this would require the conditions for inclusion of a
particular resource struct to be modified for every new driver written, for a
gain of just a few (sizeof (struct resource)) bytes.

If you find these rather lengthy explanations confusing (which I am afraid they
are), then I suggest you have a look at the code, which is really simple.

Thomas

-- 
Thomas Koeller
thomas@koeller.dyndns.org
