Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2016 18:10:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57934 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993340AbcLURKRi07dB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Dec 2016 18:10:17 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBLHAGcx013718;
        Wed, 21 Dec 2016 18:10:16 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBLHAGUD013717;
        Wed, 21 Dec 2016 18:10:16 +0100
Date:   Wed, 21 Dec 2016 18:10:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] MIPS: FW: Make fw_init_cmdline() to be __weak.
Message-ID: <20161221171015.GA13689@linux-mips.org>
References: <b14ef49d-f39c-4e13-2da8-ab94804395a2@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14ef49d-f39c-4e13-2da8-ab94804395a2@cavium.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56112
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

On Tue, Nov 22, 2016 at 01:43:54PM -0600, Steven J. Hill wrote:

> Some bootloaders pass the kernel parameters in different registers.
> Allow for platform-specific initialization of the command line.
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> ---
>  arch/mips/include/asm/fw/fw.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/fw/fw.h b/arch/mips/include/asm/fw/fw.h
> index d0ef8b4..0fcd63e 100644
> --- a/arch/mips/include/asm/fw/fw.h
> +++ b/arch/mips/include/asm/fw/fw.h
> @@ -21,7 +21,7 @@
>  #define fw_argv(index)		((char *)(long)_fw_argv[(index)])
>  #define fw_envp(index)		((char *)(long)_fw_envp[(index)])
> 
> -extern void fw_init_cmdline(void);
> +extern void __weak fw_init_cmdline(void);
>  extern char *fw_getcmdline(void);
>  extern void fw_meminit(void);
>  extern char *fw_getenv(char *name);

Nice try - expect it doesn't work.

The definition of the function needs to be marked __weak; marking the
declaration will only kindly express your wishes to GCC and it being
GCC will ignore them ;-)

  Ralf
