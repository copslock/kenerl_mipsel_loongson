Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 11:49:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9276 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009237AbcAYKtrazqO9 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2016 11:49:47 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id F22CA9A53B015;
        Mon, 25 Jan 2016 10:49:38 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775%25]) with mapi id
 14.03.0235.001; Mon, 25 Jan 2016 10:49:40 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
CC:     James Hogan <James.Hogan@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH] ld-version: fix it on Fedora
Thread-Topic: [PATCH] ld-version: fix it on Fedora
Thread-Index: AQHRTiSm06OWSy7R702Mpze/gPXRWp75re5ggA+N/YCAAuChww==
Date:   Mon, 25 Jan 2016 10:49:39 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F45D179FA@HHMAIL01.hh.imgtec.org>
References: <1452189189-31188-1-git-send-email-mst@redhat.com>
 <CAAG0J995iCNwdN6PpuJfzo+TVWNXR3UVqS9v-4HXbryyvMn+=w@mail.gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F45D04AA7@HHMAIL01.hh.imgtec.org>,<CAJ1xhMWth4kNuEkuVEUiUEz=d_9dmKxh0+Z_GrRcKB+F72W91w@mail.gmail.com>
In-Reply-To: <CAJ1xhMWth4kNuEkuVEUiUEz=d_9dmKxh0+Z_GrRcKB+F72W91w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.101.28]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Daniel.Sanders@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> From: Alexander Kapshuk [alexander.kapshuk@gmail.com]
> Sent: 23 January 2016 14:41
> To: Daniel Sanders
> Cc: James Hogan; Michael S. Tsirkin; LKML; Michal Marek; linux-kbuild@vger.kernel.org; Linux MIPS Mailing List; Ralf Baechle
> Subject: Re: [PATCH] ld-version: fix it on Fedora
> 
> On Wed, Jan 13, 2016 at 7:30 PM, Daniel Sanders <Daniel.Sanders@imgtec.com<mailto:Daniel.Sanders@imgtec.com>> wrote:
> Hi,
> 
> The version number that's giving me problems is 2.24.51.20140217 which ld-version.sh converts to 2036931700 (20000000+2400000+510000+2014021700).
> 
> At the moment, I'm wondering whether we really need to handle more than three version number components. Another thought is that the comparison could be inside ld-version.sh (or a replacement) so that it can compare the array of version components directly instead of using a constructed integer as a proxy.
> 
> > -----Original Message-----
> > From: james@albanarts.com<mailto:james@albanarts.com> [mailto:james@albanarts.com<mailto:james@albanarts.com>] On Behalf Of
> > James Hogan
> > Sent: 13 January 2016 17:06
> > To: Michael S. Tsirkin
> > Cc: LKML; Michal Marek; linux-kbuild@vger.kernel.org<mailto:linux-kbuild@vger.kernel.org>; Linux MIPS Mailing
> > List; Ralf Baechle; Daniel Sanders
> > Subject: Re: [PATCH] ld-version: fix it on Fedora
> >
> > Cc'ing Daniel, who has hit further breakage due to unusual version numbers.
> >
> > On 7 January 2016 at 17:55, Michael S. Tsirkin <mst@redhat.com<mailto:mst@redhat.com>> wrote:
> > > On Fedora 23, ld --version outputs:
> > > GNU ld version 2.25-15.fc23
> > >
> > > But ld-version.sh fails to parse this, so e.g.  mips build fails to
> > > enable VDSO, printing a warning that binutils >= 2.24 is required.
> > >
> > > To fix, teach ld-version to parse this format.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com<mailto:mst@redhat.com>>
> > > ---
> > >
> > > Which tree should this be merged through? Mine? MIPS?
> > >
> > >  scripts/ld-version.sh | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> > > index 198580d..25d23c8 100755
> > > --- a/scripts/ld-version.sh
> > > +++ b/scripts/ld-version.sh
> > > @@ -2,6 +2,8 @@
> > >  # extract linker version number from stdin and turn into single number
> > >         {
> > >         gsub(".*)", "");
> > > +       gsub(".*version ", "");
> > > +       gsub("-.*", "");
> > >         split($1,a, ".");
> > >         print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
> > >         exit
> > > --
> > > MST
> > >
> 
> Is this the output you're looking for?
> 
> % echo 'GNU ld version 2.25-15.fc23' |
> > awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> > match($0, /[0-9]+([.]?[0-9]+)+/)
> > bin=substr($0,RSTART,RLENGTH)
> > split(bin, a, ".")
> > print a[1]*10000000 + a[2]*100000 + a[3]*10000}'
> 22500000
> 
> % echo 2.25.1.20140217 |
> > awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> > match($0, /[0-9]+([.]?[0-9]+)+/)
> > bin=substr($0,RSTART,RLENGTH)
> > split(bin, a, ".")
> > print a[1]*10000000 + a[2]*100000 + a[3]*10000}'
> 22510000
> 
> awk parsing code taken from ver_linux:
> /usr/src/linux/scripts/ver_linux:28,33
> ld -v 2>&1 |
> awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
>     match($0, /[0-9]+([.]?[0-9]+)+/)
>     printf("Binutils\t\t%s\n",
>     substr($0,RSTART,RLENGTH))
> }'
> 

It's close. That code doesn't quite work for my version number because the third component has two
digits and overflows into the second component in the proxy integer:
$ echo 2.24.51.20140217 |
> awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> match($0, /[0-9]+([.]?[0-9]+)+/)
> bin=substr($0,RSTART,RLENGTH)
> split(bin, a, ".")
> print a[1]*10000000 + a[2]*100000 + a[3]*10000}'
22910000

but adding a zero to the first two scale factors, or removing one from the third works for me.
$ echo 2.24.51.20140217 | awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> match($0, /[0-9]+([.]?[0-9]+)+/)
> bin=substr($0,RSTART,RLENGTH)
> split(bin, a, ".")
> print a[1]*100000000 + a[2]*1000000 + a[3]*10000}'
224510000
$ echo 2.24.51.20140217 | awk '/[0-9]+([.]?[0-9]+)+/ && !/not found$/{
> match($0, /[0-9]+([.]?[0-9]+)+/)
> bin=substr($0,RSTART,RLENGTH)
> split(bin, a, ".")
> print a[1]*10000000 + a[2]*100000 + a[3]*1000}'
22451000
From will.deacon@arm.com Mon Jan 25 15:41:50 2016
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 15:41:51 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:48045 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011398AbcAYOltaRzzk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 15:41:49 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE96F49;
        Mon, 25 Jan 2016 06:41:01 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E89D3F24D;
        Mon, 25 Jan 2016 06:41:37 -0800 (PST)
Date:   Mon, 25 Jan 2016 14:41:34 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160125144133.GB22927@arm.com>
References: <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
 <20160115102431.GB2131@arm.com>
 <20160115175401.GW3818@linux.vnet.ibm.com>
 <20160115192845.GA12510@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115192845.GA12510@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Content-Length: 1892
Lines: 72

On Fri, Jan 15, 2016 at 11:28:45AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 15, 2016 at 09:54:01AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 15, 2016 at 10:24:32AM +0000, Will Deacon wrote:
> > > See my earlier reply [1] (but also, your WRC Linux example looks more
> > > like a variant on WWC and I couldn't really follow it).
> > 
> > I will revisit my WRC Linux example.  And yes, creating litmus tests
> > that use non-fake dependencies is still a bit of an undertaking.  :-/
> > I am sure that it will seem more natural with time and experience...
> 
> Hmmm...  You are quite right, I did do WWC.  I need to change cpu2()'s
> last access from a store to a load to get WRC.  Plus the levels of
> indirection definitely didn't match up, did they?

Nope, it was pretty baffling!

> 	struct foo {
> 		struct foo *next;
> 	};
> 	struct foo a;
> 	struct foo b;
> 	struct foo c = { &a };
> 	struct foo d = { &b };
> 	struct foo x = { &c };
> 	struct foo y = { &d };
> 	struct foo *r1, *r2, *r3;
> 
> 	void cpu0(void)
> 	{
> 		WRITE_ONCE(x.next, &y);
> 	}
> 
> 	void cpu1(void)
> 	{
> 		r1 = lockless_dereference(x.next);
> 		WRITE_ONCE(r1->next, &x);
> 	}
> 
> 	void cpu2(void)
> 	{
> 		r2 = lockless_dereference(y.next);
> 		r3 = READ_ONCE(r2->next);
> 	}
> 
> In this case, it is legal to end the run with:
> 
> 	r1 == &y && r2 == &x && r3 == &c
> 
> Please see below for a ppcmem litmus test.
> 
> So, did I get it right this time?  ;-)

The code above looks correct to me (in that it matches WRC+addrs),
but your litmus test:

> PPC WRCnf+addrs
> ""
> {
> 0:r2=x; 0:r3=y;
> 1:r2=x; 1:r3=y;
> 2:r2=x; 2:r3=y;
> c=a; d=b; x=c; y=d;
> }
>  P0           | P1            | P2            ;
>  stw r3,0(r2) | lwz r8,0(r2)  | lwz r8,0(r3)  ;
>               | stw r2,0(r3)  | lwz r9,0(r8)  ;
> exists
> (1:r8=y /\ 2:r8=x /\ 2:r9=c)

Seems to be missing the address dependency on P1.

Will
