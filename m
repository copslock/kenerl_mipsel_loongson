Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2005 01:20:14 +0100 (BST)
Received: from web31508.mail.mud.yahoo.com ([68.142.198.137]:47968 "HELO
	web31508.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133376AbVIWAT4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Sep 2005 01:19:56 +0100
Received: (qmail 63087 invoked by uid 60001); 23 Sep 2005 00:19:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HyLdzuU9rA3OkyBZsu0ocLemY8ze7/Nv/fK1UgusQ36vacqi/4+ZFrYxlxWV99moOAtpYIrHp6wqoDMQVp02XJXuClyh16XS3nPXccfv6t9r4b21x+ggP0stvIATLdPgCsY6z6t8rxOUFoRJGdD4xBeaaOeeSBcrAGjkyZT1Y/A=  ;
Message-ID: <20050923001949.63085.qmail@web31508.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31508.mail.mud.yahoo.com via HTTP; Thu, 22 Sep 2005 17:19:49 PDT
Date:	Thu, 22 Sep 2005 17:19:49 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: Building the kernel for a Broadcom SB1
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Andy Isaacson <adi@hexapodia.org>, linux-mips@linux-mips.org
In-Reply-To: <20050922213209.GB15905@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

I'm trying the patches with various configurations.
Every kernel I've tried building with both the
kobjects and debug info enabled in the kernel hacking
menu will work fine. Any kernel with either (or both)
disabled will lock up on boot.

At this time, I have no clear idea as to why the
debugs are making such a big difference. Particularly
if other people aren't experiencing exactly the same
problem. Any thoughts would be welcome.

--- Daniel Jacobowitz <dan@debian.org> wrote:

> On Thu, Sep 22, 2005 at 10:22:50AM -0700, Jonathan
> Day wrote:
> > Loading: 0xffffffff80100000/2903912
> > 0xffffffff803c4f68/305896 Entry at
> > 0xffffffff80396000
> > Closing network.
> > Starting program at 0xffffffff80396000
> > Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
> > Board type: SiByte BCM91250E (Sentosa)
> 
> [*hang* here]
> 
> Andy's patches should fix this; I grabbed them from
> Thiemo's
> experimental Debian packages a couple of days ago
> and they brought my
> Sentosa up again.
> 
> -- 
> Daniel Jacobowitz
> CodeSourcery, LLC
> 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
