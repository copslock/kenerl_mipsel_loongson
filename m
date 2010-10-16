Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 08:17:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56088 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491003Ab0JPGRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Oct 2010 08:17:45 +0200
Date:   Sat, 16 Oct 2010 07:17:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Stuart Longland <redhatter@gentoo.org>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC MIPS] Update buildtar for MIPS
In-Reply-To: <1286502337-23882-1-git-send-email-redhatter@gentoo.org>
Message-ID: <alpine.LFD.2.00.1010160716270.15889@eddie.linux-mips.org>
References: <1286502337-23882-1-git-send-email-redhatter@gentoo.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 8 Oct 2010, Stuart Longland wrote:

> This updates buildtar to support MIPS targets.  MIPS may use 'vmlinux'
> or 'vmlinux.32' depending on the target system.

 Or vmlinux.64 -- why don't you handle that too?

  Maciej
