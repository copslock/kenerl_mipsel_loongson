Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 12:47:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15309 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021939AbXEXLrh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 May 2007 12:47:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4OBlOii031848;
	Thu, 24 May 2007 12:47:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4OBlNd4031847;
	Thu, 24 May 2007 12:47:23 +0100
Date:	Thu, 24 May 2007 12:47:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org, Martin Michlmayr <tbm@cyrius.com>
Subject: Re: SGI O2 meth: missing sysfs device symlink
Message-ID: <20070524114723.GA27073@linux-mips.org>
References: <1178743456.15447.41.camel@scarafaggio> <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org> <20070517151636.GJ3586@deprecation.cyrius.com> <20070521154726.GE5943@linux-mips.org> <20070522110956.GB29118@linux-mips.org> <1179834093.7896.23.camel@scarafaggio> <1179835991.7896.32.camel@scarafaggio> <1179920735.6770.6.camel@scarafaggio>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1179920735.6770.6.camel@scarafaggio>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 23, 2007 at 01:45:35PM +0200, Giuseppe Sacco wrote:

> I got 2.6.21.1 source, then I applied patch-2.6.22-rc2.bz2 and your
> patch. I compiled everything with this command:
> 
> # make-kpkg clean
> # time make-kpkg --revision 2:2.6.22~rc2 \
> -append-to-version -r5k-ip32 --arch-in-name buildpackage
> 
> and got this result:
> 
> [...]
>   CC [M]  net/ipv6/reassembly.o
>   CC [M]  net/ipv6/tcp_ipv6.o
>   CC [M]  net/ipv6/exthdrs.o
> net/ipv6/exthdrs.c: In function ‘ipv6_rthdr_rcv’:
> net/ipv6/exthdrs.c:390: error: ‘struct sk_buff’ has no member named ‘h’
> net/ipv6/exthdrs.c:391: error: ‘struct sk_buff’ has no member named ‘h’
> net/ipv6/exthdrs.c:391: error: ‘struct sk_buff’ has no member named ‘h’
> net/ipv6/exthdrs.c:398: error: ‘struct sk_buff’ has no member named ‘h’
> make[4]: *** [net/ipv6/exthdrs.o] Error 1
> make[3]: *** [net/ipv6] Error 2
> make[2]: *** [net] Error 2
> make[2]: Leaving directory `/home/src/linux-2.6.22-rc2'
> make[1]: *** [debian/stamp-build-kernel] Error 2
> make[1]: Leaving directory `/home/src/linux-2.6.22-rc2'
> make: *** [stamp-buildpackage] Error 2
> 
> real    409m49.142s
> user    250m33.296s
> sys     15m41.356s
> sgi:/usr/local/src/linux-2.6.22-rc2# bc

Unrelated problem.  If you can reproduce it with a vanilla kernel report
to netdev@vger.kernel.org.

  Ralf

  Ralf
