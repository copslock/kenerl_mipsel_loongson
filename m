Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 18:08:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35076 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6868731Ab3JGQI0ndH9S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 18:08:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r97G8OQY013597;
        Mon, 7 Oct 2013 18:08:24 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r97G8L8U013593;
        Mon, 7 Oct 2013 18:08:21 +0200
Date:   Mon, 7 Oct 2013 18:08:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ashok Kumar <ashoks@broadcom.com>
Cc:     linux-mips@linux-mips.org, gerg@uclinux.org
Subject: Re: [PATCH] MIPS: fix mapstart when using initrd
Message-ID: <20131007160821.GA1615@linux-mips.org>
References: <1379945426-32205-1-git-send-email-ashoks@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1379945426-32205-1-git-send-email-ashoks@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, Sep 23, 2013 at 07:40:26PM +0530, Ashok Kumar wrote:
> Date:   Mon, 23 Sep 2013 19:40:26 +0530
> From: Ashok Kumar <ashoks@broadcom.com>
> To: linux-mips@linux-mips.org, gerg@uclinux.org
> cc: ralf@linux-mips.org, Ashok Kumar <ashoks@broadcom.com>
> Subject: [PATCH] MIPS: fix mapstart when using initrd
> Content-Type: text/plain
> 
> When initrd is present in the PFN right after the _end, bootmem
> bitmap(mapstart) overwrites it. So check for initrd_end in
> mapstart calculation.
> 
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> ---
> This is seen after the commit
> "mips: fix start of free memory when using initrd"
> in git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git branch
> 
> Tested the image on MIPS platform creating the above
> said scenario and initrd was corrupted.

And it gloriously breaks the build if CONFIG_BLK_DEV_INITRD is disabled.
Now most configurations will fail with something like:

[...]
  LD      vmlinux
arch/mips/built-in.o: In function `setup_arch':
(.init.text+0xff8): undefined reference to `initrd_end'
arch/mips/built-in.o: In function `setup_arch':
(.init.text+0xffc): undefined reference to `initrd_end'
make[2]: *** [vmlinux] Error 1
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2
make: Leaving directory `/home/ralf/src/linux/obj/lasat-build'

  Ralf
