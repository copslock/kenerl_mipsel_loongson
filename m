Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 19:38:15 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:61952 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903700Ab2A3SiJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2012 19:38:09 +0100
Received: by dadz9 with SMTP id z9so3407117dad.36
        for <multiple recipients>; Mon, 30 Jan 2012 10:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C4WGZsbwNYQIjS6j00QgwzT6wzUh/YjytanaiGZQXhk=;
        b=q4jyczTmd+DUVx4EJPSVNz4E//Efc+MPQIKaa1LHRksYsPUpsYjcAEGN/pDM+jGKg5
         pgtNtXmYJkT8NKhEEL8maJB4UDXucYqzqEPCPGoebHK5Feq5WDFTc0pzDc+T6hr53lsa
         7xPxmXDATbBWftHlKL5On4tedCCIYW3x048bw=
MIME-Version: 1.0
Received: by 10.68.130.201 with SMTP id og9mr43325418pbb.61.1327948682951;
 Mon, 30 Jan 2012 10:38:02 -0800 (PST)
Received: by 10.68.234.166 with HTTP; Mon, 30 Jan 2012 10:38:02 -0800 (PST)
In-Reply-To: <4F26CD48.3040809@gmail.com>
References: <0736d2becb10905c35eec74f04c63970@localhost>
        <4F26CD48.3040809@gmail.com>
Date:   Mon, 30 Jan 2012 10:38:02 -0800
Message-ID: <CAJiQ=7DXJvnt0NZLiThiH+FiQ43GTm07ODJs6e4-RbpsBSxAKQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix duplicate instances of ARCH_SPARSEMEM_ENABLE
From:   Kevin Cernekee <cernekee@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>, viric@viric.name
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 32334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Jan 30, 2012 at 9:03 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> NAK!
>
> A cleaner patch for this was already done here:
>
> http://patchwork.linux-mips.org/patch/3285/

This patch fixed the problem for me, but it doesn't apply cleanly to
the current head of tree since the context (CAVIUM_OCTEON_HELPER) has
changed.

Lluis, do you want to go ahead and submit a V2?

Thanks.
