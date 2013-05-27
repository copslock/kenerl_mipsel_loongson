Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 14:32:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50232 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823763Ab3E0McDr9CsD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 14:32:03 +0200
Date:   Mon, 27 May 2013 13:32:03 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, Steven.Hill@imgtec.com,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/3] MIPS: microMIPS: Fix POOL16C minor opcode enum
In-Reply-To: <20130527105959.GB31548@hades>
Message-ID: <alpine.LFD.2.03.1305271329520.18557@linux-mips.org>
References: <20130527105810.GA31548@hades> <20130527105959.GB31548@hades>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 27 May 2013, Tony Wu wrote:

> diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
> index 0f4aec2..473a2ac 100644
> --- a/arch/mips/include/uapi/asm/inst.h
> +++ b/arch/mips/include/uapi/asm/inst.h
> @@ -409,10 +409,11 @@ enum mm_32f_73_minor_op {
>  enum mm_16c_minor_op {
>  	mm_lwm16_op = 0x04,
>  	mm_swm16_op = 0x05,
> -	mm_jr16_op = 0x18,
> -	mm_jrc_op = 0x1a,
> -	mm_jalr16_op = 0x1c,
> -	mm_jalrs16_op = 0x1e,
> +	mm_jr16_op = 0x0c,
> +	mm_jraddiusp_op = 0x18,
> +	mm_jrc_op = 0x0d,
> +	mm_jalr16_op = 0x1e,
> +	mm_jalrs16_op = 0x1f,
>  };

 Please keep these sorted by value, and also mm_jalr16_op and 
mm_jalrs16_op are wrong.

  Maciej
