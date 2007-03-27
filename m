Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 04:18:00 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:15304 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021288AbXC0DR6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 04:17:58 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 27 Mar 2007 12:17:57 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2B10920494;
	Tue, 27 Mar 2007 12:17:35 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1DFC0203F1;
	Tue, 27 Mar 2007 12:17:35 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2R3HXW0082363;
	Tue, 27 Mar 2007 12:17:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 27 Mar 2007 12:17:33 +0900 (JST)
Message-Id: <20070327.121733.130850411.nemoto@toshiba-tops.co.jp>
To:	Ravi.Pratap@hillcrestlabs.com
Cc:	ralf@linux-mips.org, ddaney@avtrex.com, miklos@szeredi.hu,
	linux-mips@linux-mips.org
Subject: Re: flush_anon_page for MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <36E4692623C5974BA6661C0B18EE8EDF6CD4AF@MAILSERV.hcrest.com>
References: <20070326140542.GA14354@linux-mips.org>
	<36E4692623C5974BA6661C0B18EE8EDF6CD4AF@MAILSERV.hcrest.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Mar 2007 19:24:45 -0400, "Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com> wrote:
> So I'm trying to backport these changesets and it seems that I need the
> changeset that originally introduced kmap_coherent, etc. I tried some
> Google searching and found this but I need your help in figuring out
> which exact changesets I need.
> 
> Is it this one:
> 
> b895b66990f22a8a030c41390c538660a02bb97f
> 
> ?

It was splitted into some parts when merged to mainline.

At 2.6.19 cycle:
f8829caee311207afbc882794bdc5aa0db5caf33
At 2.6.20 cycle:
bcd022801ee514e28c32837f0b3ce18c775f1a7b
9de455b20705f36384a711d4a20bcf7ba1ab180b
77fff4ae2b7bba6d66a8287d9ab948e2b6c16145

If you only needed kmap_coherent, the first one might be enough.
---
Atsushi Nemoto
