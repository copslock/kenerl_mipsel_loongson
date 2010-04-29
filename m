Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 18:28:23 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42424 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492131Ab0D2Q2T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Apr 2010 18:28:19 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3TGSI9t027275;
        Thu, 29 Apr 2010 17:28:18 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3TGSHt8027273;
        Thu, 29 Apr 2010 17:28:17 +0100
Date:   Thu, 29 Apr 2010 17:28:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] arch/mips/loongson/common/mem.c: fix find_vga_mem_init()
Message-ID: <20100429162816.GC25765@linux-mips.org>
References: <m3wrvqwpew.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wrvqwpew.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 29, 2010 at 11:58:47AM +0200, Arnaud Patard wrote:
> Date:   Thu, 29 Apr 2010 11:58:47 +0200
> From: Arnaud Patard <apatard@mandriva.com>
> To: linux-mips@linux-mips.org
> Subject: [PATCH] arch/mips/loongson/common/mem.c: fix find_vga_mem_init()
> Content-Type: multipart/mixed; boundary="=-=-="
> 
> 
> This patchis patch allows to use all display device for instance
> DISPLAY_OTHER like SM501.
> 
> From: Richard LIU <richard.liu@st.com>
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Applied - but:

 o A From line to override the author derived from the email headers MUST
   be the first line of an email or git-am will ignore it.  No, editing
   the commit messages doesn't help.  I have to edit the raw mailbody and
   blody MIME attachments aren't makeing that any easier.
 o Signed-off-by: line for the author missing.

Thanks,

  Ralf
