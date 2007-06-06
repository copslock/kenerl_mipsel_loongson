Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 18:03:56 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:7146 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027087AbXFFRDx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 18:03:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l56Gwr3t032092;
	Wed, 6 Jun 2007 17:58:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l56GwqD8032091;
	Wed, 6 Jun 2007 17:58:52 +0100
Date:	Wed, 6 Jun 2007 17:58:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tian <tiansm@lemote.com>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Mailing patches
Message-ID: <20070606165852.GC29713@linux-mips.org>
References: <20070604133551.GA24405@linux-mips.org> <4664DB12.80906@gentoo.org> <20070605152338.GA22937@linux-mips.org> <4666418C.9040401@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4666418C.9040401@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 06, 2007 at 01:09:32PM +0800, Tian wrote:

> sorry for the mess，when git-format-patch , wo forgot the -n para
> and i would like to know what command para is recommended for sending
> patch on maillist?
> 
> git-send-email --no-chain-reply-to --compose --from tiansm@lemote.com 
> --no-signed-off-by-cc --smtp-server <server> --subject "Lemote Loongson 
> 2E patch update" --suppress-from --to linux-mips@linux-mips.org 00*
> 
> --no-chain-reply-to or --chain-reply-to ?
> 
> and.....should i resend the patches?

No, that's fine.

I don't like --no-chain-reply-to for no better reason than that looking
a bit odd in some threded mail readers.  But that's just a matter of
preference not a technical need.

The ordering of patches is guaranteed even without chain reply mode
because git-send-email will ensure the dates of each email is different
from the previous one.

  Ralf
