Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 13:03:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44638 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491112Ab1CXMDe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 13:03:34 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p2OC3BEW021196;
        Thu, 24 Mar 2011 13:03:11 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p2OC37pw021194;
        Thu, 24 Mar 2011 13:03:07 +0100
Date:   Thu, 24 Mar 2011 13:03:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Heiher <admin@heiher.info>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>, akmp@linux-mips.org
Subject: Re: [PATCH] Fixup personality in different ABI.
Message-ID: <20110324120307.GA20408@linux-mips.org>
References: <AANLkTikuBxnd0bFsO5NP2GQYDZmGFP9kLruWVpjZ7+UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikuBxnd0bFsO5NP2GQYDZmGFP9kLruWVpjZ7+UQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 18, 2011 at 12:58:23PM +0800, Heiher wrote:
> Date:   Fri, 18 Mar 2011 12:58:23 +0800
> From: Heiher <admin@heiher.info>
> To: linux-kernel@vger.kernel.org

Please don't post a patch seperately to multiple lists.  Cc is prefered
so everybody gets to see all replies.

> >From bf3637153bc5e3d0e3f1c2982c323057a8e04801 Mon Sep 17 00:00:00 2001
> From: Heiher <admin@heiher.info>
> Date: Fri, 18 Mar 2011 12:51:08 +0800
> Subject: [PATCH] Fixup personality in different ABI.
> 
> * 'arch' output:
> 	o32 : mips
> 	n32 : mips64
> 	64  : mips64

That's the correct behaviour - the personality gets inherited by the parent.
If you want to invoke a process with a different personality you can do this
with a utility like arch32 or setarch.

  Ralf
