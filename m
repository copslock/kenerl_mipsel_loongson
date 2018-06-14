Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2018 12:07:34 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:45987
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993016AbeFNKHZfB5Gi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jun 2018 12:07:25 +0200
Received: by mail-lf0-x244.google.com with SMTP id n3-v6so8480005lfe.12;
        Thu, 14 Jun 2018 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lah5Gb3LjbyT/v0bjCif2j1q5nF8aHLOdsVULUBXikA=;
        b=h7hu8+G2AWLVDBEteXIZx8fFPuIkgnKUTWbTmbOs+H+QTmIWK/qqzkG6w+kGzi4Ams
         ebPCyFF/GXV6uLDu+d2L7sVJ6qfEef6Tyfdoa78idXYwxrf4NU6X8wDTIteAJhUOCIfD
         oZQlzfCw1RFMe2+lo+T+kSeEM9DLe0gfBd6/AxeHPhaCWyZUoEoA2YSll5s+QTzLgVgp
         LIe4E7l88/H2+uqQdpo26I8WleNACbQQrsHZRB8YAGaAKl9QhUsYluneFbZnmGWgYNzH
         cbkdmodQBumlVfWFlU4TW1lTVDlk+SONfQuZNxJVqzBxx6idfiesELh1z6Efh9MThhi1
         Yk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lah5Gb3LjbyT/v0bjCif2j1q5nF8aHLOdsVULUBXikA=;
        b=ghh6KE2XSAtror6tkv3XJabXX7psL0OPwZe0rxUQa6clA35q7spQkqGjCBSlMcmWCJ
         +5HZ0oieeIPeu5SH1d+bN27aSNrvEP+WawZzu7ZWevM8Kfad9SyNFmGB9CHlVom2Ng2r
         UJuDJSfQ27JlDLBLcXwUfDRz4Q4Dq0aRSoQ7rtlfvozoN2A/mW9Biczui+Jr9uKvqyg3
         qeQdJm+q5bHgJD5obCrcbmKfHrpZa6oGfopXqJce0HYzQPUnoHDbqVTWA4SlUYHjPhho
         e8Xix5foV4bGT23t4O4m8IvsE0CkA55Tq2W9aWF/x9an7KuSoVnezE88ISbRAlVp94DG
         yXvg==
X-Gm-Message-State: APt69E1k0zZr2AWs+QRSQ/KZLZmfbTKOJB3Z2GzduxYdrdRaJFxx/Jqb
        IFWokl9eMu9CLyR6su3DPDNP+Tt8u5w9mkF/47s=
X-Google-Smtp-Source: ADUXVKIJ8qWAVRB5bQ5MRhz+OZpP9pxupJT/g9aAwOUMkkHaWkTEC9dplmKc7KfSHYQk1OUPdHHUi2v3P+isLS/nnOc=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr5828419lfc.55.1528970840104;
 Thu, 14 Jun 2018 03:07:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:07:19
 -0700 (PDT)
In-Reply-To: <20180612054034.4969-5-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com> <20180612054034.4969-5-songjun.wu@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jun 2018 12:07:19 +0200
X-Google-Sender-Auth: _wKB8UeZIwZ5de5NPaloC9YPF9U
Message-ID: <CAK8P3a0K6qezHLcjkeq0zd+iQJQc_qbT2JhtZGrCNRT495sUvQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Previous implementation uses platform-dependent functions
> ltq_w32()/ltq_r32() to access registers. Those functions are not
> available for other SoC which uses the same IP.
> Change to OS provided readl()/writel() and readb()/writeb(), so
> that different SoCs can use the same driver.
>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

Are there any big-endian machines using this driver? The original definition
of ltq_r32() uses non-byteswapping __raw_readl() etc, which suggests
that the registers might be wired up in a way that matches the CPU
endianess (this is usally a bad idea in hardware design, but nothing
we can influence in the OS).

When you change it to readl(), that will breaks all machines that rely
on the old behavior on big-endian kernels.

      Arnd
