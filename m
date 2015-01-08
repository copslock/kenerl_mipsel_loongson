Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2015 02:18:24 +0100 (CET)
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35371 "EHLO
        mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009610AbbAHBSWuW0VT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jan 2015 02:18:22 +0100
Received: by mail-qg0-f45.google.com with SMTP id z107so175232qgd.4;
        Wed, 07 Jan 2015 17:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=RajBmSQvPeOQZo1grhMiCTJWHJs8dcmm9LGhQo4hmMI=;
        b=0njT9n7y9z9nKhwBRZNYMczooeXKsKin6aDJuEyJkktQQkZ+vAEel4RdT77EHyDA7j
         4XR0mKJrA8vw7Y1zEwsCmORQahafOJbx85DynluPP0QUFo1YdfmefkH1xFW8MkW+LOyn
         /wJe2wCQ0ySo2i0ei5k1uqqtG+GeB4sR9rlF9IwSTphWDpIPtb4PAPocvSO0I+UersmP
         ANH515tZ59GedPVLZ/cPsQdZZ/sK1qEGngokE031YqAEari14YFEXNf+dcYbSFEymvW2
         hvn5leuVkAImZ1Rgr4SLZP5lcrykLnLMvGfn6QbQ9s3qpQ31oEJ9KD6E/hKt7/Dskajl
         fYtg==
X-Received: by 10.140.98.33 with SMTP id n30mr9801740qge.62.1420679897103;
 Wed, 07 Jan 2015 17:18:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.96.89.33 with HTTP; Wed, 7 Jan 2015 17:17:56 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 7 Jan 2015 17:17:56 -0800
Message-ID: <CAADnVQK0oM6U6qNuBn7H-DZHTdxzYjGrP2M7dvaOrdHztRw1eQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] module: remove mod arg from module_free, rename module_memfree().
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        linux-cris-kernel@axis.com, linux-mips <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Wed, Jan 7, 2015 at 4:58 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
>  void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       module_free(NULL, hdr);
> +       module_memfree(hdr);
>  }
...
> -void __weak module_free(struct module *mod, void *module_region)
> +void __weak module_memfree(void *module_region)
>  {
>         vfree(module_region);
>  }

Looks obviously correct.
Acked-by: Alexei Starovoitov <ast@kernel.org>
