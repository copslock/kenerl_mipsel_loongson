Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2003 08:25:37 +0100 (BST)
Received: from 12-234-18-241.client.attbi.com ([IPv6:::ffff:12.234.18.241]:20357
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225073AbTD3HZf>; Wed, 30 Apr 2003 08:25:35 +0100
Received: from localhost.localdomain (greglaptop [127.0.0.1])
	by localhost.localdomain (8.12.8/8.12.5) with ESMTP id h3U7OpEh002749
	for <linux-mips@linux-mips.org>; Wed, 30 Apr 2003 00:25:25 -0700
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.8/8.12.8/Submit) id h3U7Oo1P002747
	for linux-mips@linux-mips.org; Wed, 30 Apr 2003 00:24:50 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Wed, 30 Apr 2003 00:24:50 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Message-ID: <20030430072450.GA2741@greglaptop.attbi.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <BAY1-F93dHd6z6BJ8Qi0001d2c1@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-F93dHd6z6BJ8Qi0001d2c1@hotmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 30, 2003 at 12:13:08AM -0700, Michael Anburaj wrote:

> I guess it's something to do with the FPU option ( not sure).. Please help 
> me with this. I wonder why its still refering to files from arch/i386

That's hiding in your dependency files. Are you sure that "make dep" worked?

"make mrproper" will return your kernel tree to a pretty clean state. Then
you'll have to start over with configuration, make dep, make.

greg
