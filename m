Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 21:34:21 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:33041 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20031387AbXJLUeM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 21:34:12 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 67CCBD8DF; Fri, 12 Oct 2007 20:34:06 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id DF80754585; Fri, 12 Oct 2007 22:33:54 +0200 (CEST)
Date:	Fri, 12 Oct 2007 22:33:54 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Gcc 4.2.2 broken for kernel builds
Message-ID: <20071012203354.GA18618@deprecation.cyrius.com>
References: <20071012172254.GA10835@linux-mips.org> <470FB386.6080709@avtrex.com> <20071012175317.GB1110@linux-mips.org> <470FBE08.8090004@avtrex.com> <20071012184909.GA4832@linux-mips.org> <20071012191446.GK3163@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071012191446.GK3163@deprecation.cyrius.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2007-10-12 21:14]:
> Okay, I can see it.  I'll submit a testcase.

I submitted the following:

(sid)335:tbm@swarm: ~] gcc-4.2 -c -march=mips32r2 -O2 pr33755.c
(sid)336:tbm@swarm: ~] ld -m elf32ltsmip -r pr33755.o
ld: pr33755.o: Can't find matching LO16 reloc against `$LC0' for R_MIPS_GOT16 at 0x521490 in section `.text'
(sid)337:tbm@swarm: ~] cat pr33755.c
struct mtd_blktrans_ops
{
  int (*readsect) (void);
  int exiting;
};
static void do_blktrans_request (struct mtd_blktrans_ops *tr, long flags)
{
  switch (flags & 1)
    {
    case 0:
      if (tr->readsect ())
        return;
    case 1:
      return;
    default:
      printk ("foo\n");
    }
}
mtd_blktrans_thread (struct mtd_blktrans_ops *tr)
{
  long flags;
  while (!tr->exiting)
      do_blktrans_request (tr, flags);
}

-- 
Martin Michlmayr
http://www.cyrius.com/
