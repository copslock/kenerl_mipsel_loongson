Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 16:18:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56994 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832092Ab3FMOSW04K14 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jun 2013 16:18:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5DEILMi024347;
        Thu, 13 Jun 2013 16:18:21 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5DEIKH2024346;
        Thu, 13 Jun 2013 16:18:20 +0200
Date:   Thu, 13 Jun 2013 16:18:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: sead3: Fix incorrect values for soft reset.
Message-ID: <20130613141820.GB22906@linux-mips.org>
References: <1371075656-21374-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371075656-21374-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36853
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

On Wed, Jun 12, 2013 at 05:20:56PM -0500, Steven J. Hill wrote:

>   * Reset register.
>   */
> -#define SOFTRES_REG	  0x1f000500
> -#define GORESET		  0x42
> +#define SOFTRES_REG	  0x1f000050
> +#define GORESET		  0x4d

I think this is going to break Malta.  We used to have:

    #define SOFTRES_REG       0x1e800050
    #define GORESET           0x4d

for SEAD and

    #define SOFTRES_REG       0x1f000500
    #define GORESET           0x42

for Atlas (no longer supported) and Malta.

  Ralf
