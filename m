Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 12:46:41 +0100 (BST)
Received: from host51-222-dynamic.2-87-r.retail.telecomitalia.it ([87.2.222.51]:4879
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20021611AbXEWLqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2007 12:46:35 +0100
Received: from [80.76.68.90] (helo=pc01.bm.loc)
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1HqpEn-00078o-DR; Wed, 23 May 2007 13:42:42 +0200
Subject: Re: SGI O2 meth: missing sysfs device symlink
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <1179835991.7896.32.camel@scarafaggio>
References: <1178743456.15447.41.camel@scarafaggio>
	 <20070516151939.GH19816@deprecation.cyrius.com>
	 <20070516160313.GA3409@bongo.bofh.it>
	 <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
	 <20070517151636.GJ3586@deprecation.cyrius.com>
	 <20070521154726.GE5943@linux-mips.org>
	 <20070522110956.GB29118@linux-mips.org>
	 <1179834093.7896.23.camel@scarafaggio>
	 <1179835991.7896.32.camel@scarafaggio>
Content-Type: text/plain; charset=utf-8
Date:	Wed, 23 May 2007 13:45:35 +0200
Message-Id: <1179920735.6770.6.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8BIT
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mar, 22/05/2007 alle 14.13 +0200, Giuseppe Sacco ha scritto:
> Il giorno mar, 22/05/2007 alle 13.41 +0200, Giuseppe Sacco ha scritto:
> > Il giorno mar, 22/05/2007 alle 12.09 +0100, Ralf Baechle ha scritto:
> > > On Mon, May 21, 2007 at 04:47:26PM +0100, Ralf Baechle wrote:
> > > 
> > > Below patch is meant to cure the problem.  It's against HEAD but should
> > > apply to somewhat older problems as well.
> > > 
> > > I appreciate testing asap so I can try to still push this upstream
> > > for 2.6.22.
> > [...]
> > 
> > I may test it against 2.6.18, the standard debian kernel for stable; but
> > I will be on the console only in two days :-(
> 
> It seems the patch doesn't apply on 2.6.18, so I will recompile
> 2.6.22-rc2, but I do not know if it works on my SGI. I never tried it.

I got 2.6.21.1 source, then I applied patch-2.6.22-rc2.bz2 and your
patch. I compiled everything with this command:

# make-kpkg clean
# time make-kpkg --revision 2:2.6.22~rc2 \
-append-to-version -r5k-ip32 --arch-in-name buildpackage

and got this result:

[...]
  CC [M]  net/ipv6/reassembly.o
  CC [M]  net/ipv6/tcp_ipv6.o
  CC [M]  net/ipv6/exthdrs.o
net/ipv6/exthdrs.c: In function ‘ipv6_rthdr_rcv’:
net/ipv6/exthdrs.c:390: error: ‘struct sk_buff’ has no member named ‘h’
net/ipv6/exthdrs.c:391: error: ‘struct sk_buff’ has no member named ‘h’
net/ipv6/exthdrs.c:391: error: ‘struct sk_buff’ has no member named ‘h’
net/ipv6/exthdrs.c:398: error: ‘struct sk_buff’ has no member named ‘h’
make[4]: *** [net/ipv6/exthdrs.o] Error 1
make[3]: *** [net/ipv6] Error 2
make[2]: *** [net] Error 2
make[2]: Leaving directory `/home/src/linux-2.6.22-rc2'
make[1]: *** [debian/stamp-build-kernel] Error 2
make[1]: Leaving directory `/home/src/linux-2.6.22-rc2'
make: *** [stamp-buildpackage] Error 2

real    409m49.142s
user    250m33.296s
sys     15m41.356s
sgi:/usr/local/src/linux-2.6.22-rc2# bc
