Received:  by oss.sgi.com id <S42304AbQIYXas>;
	Mon, 25 Sep 2000 16:30:48 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.20.53]:18182
        "EHLO u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42201AbQIYXae>; Mon, 25 Sep 2000 16:30:34 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869590AbQIYX3W>;
        Tue, 26 Sep 2000 01:29:22 +0200
Date:   Tue, 26 Sep 2000 01:29:22 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Dominic Sweetman <dom@algor.co.uk>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
Message-ID: <20000926012922.A7639@bacchus.dhis.org>
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39CFC567.DD66BC56@mvista.com>; from jsun@mvista.com on Mon, Sep 25, 2000 at 02:36:39PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Sep 25, 2000 at 02:36:39PM -0700, Jun Sun wrote:

> I looked at my problem again, and it turns out that it was caused by
> "-mips2" compiler option.  If I use "-mips3", the complain goes away,
> which seems to make sense - assuming "uld" and "usw" are introduced in
> mips III.
> 
> This actually brings another question (which I thought I have posted
> before).  Take a look of arch/mips/Makefile, you will find most CPUS
> uses -mips2 compiler option.  While -mips2 is safe, it cannot take
> advantages of "uld" etc.  Is there any reason that we don't want to use
> -mips3, at least for some of the later CPUs?

You cannot use any kind of 64-bit operation for the 32-bit kernel except
for the $zero register.  This is because all exceptions as far as they
store / restore the integer registers at all will only deal with the lower
32-bit of the registers.  In other word any interrupt will corrupt the
upper 32-bit bit of gp registers.

Back in history I tried to enable the use of the full 64-bit register in
the kernel - it ended up ugly as hell, especially because we still want
to be able to share most of the code with the R3000.

> If we have to use "-mips2" option, is there a clean way which allows us
> to "uld/usw" instructions (instead of manually twicking the compilation
> for each file that uses them)?
> 
> Another question is that in the same file most CPUs will take another
> compiler option such as "-mcpu=r8000", in which case the cpu model
> usually does NOT correspond to the actual CPU.  Why is that?

-mcpu=<somecpu> chooses what CPU gcc will schedule instructions for.  No
matter what value you choose for <somecpu> the code will run on all CPUs.
-mips<n> chooses which ISA level gcc will generate code for; that code
won't run on CPUs with a ISA level less than <n>.

  Ralf
