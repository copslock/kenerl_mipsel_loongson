Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 13:52:26 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:33579
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994561AbeFRLwTHlXAj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2018 13:52:19 +0200
Received: by mail-lf0-x244.google.com with SMTP id y20-v6so24206293lfy.0;
        Mon, 18 Jun 2018 04:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=u6lapVaDPJDLDEq9Vwies/bT1iQPkezn3nOqZiIx/8A=;
        b=skCX43TnUmuqtBmGJ7eLbQt7WnI2Y2+eqRZNZtqW5uKvFEhzuGQBr7kSyQIirFpHYv
         CsN5ZoG9v0EGOvX0y/r4U4zBOHK+sdiUDn7Ecd0L9LYc0wRUSeQVjnh1XZ8zev50msWY
         cXOMyYhuRbppnr3za4IX8s/lMJ/YBUb9ZnjXRpVY/m+3KxhOxVML/07buIRedtsRPsr9
         bsMX7gi2Qq6b9VrFzT+O45hqZROWvhNWqLfy53kYalgIdFBE8xx3oDF5+GI6SYYYVm1R
         Am0A9fv94U5m9JFLR183TEO7tG0mNqkCkmejFuQEqEbeOpB8clRBC1RcPxL01kCN7cLO
         NjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=u6lapVaDPJDLDEq9Vwies/bT1iQPkezn3nOqZiIx/8A=;
        b=ifPBLBqgAlW99yIqfQdpggAiVKZtg9sLQAd+LmzNaJVQd/kbQxBiuc5eeVqmRcwgIO
         JaGFA3QNrCaoXE9LDZMlpErSsciLN6+TK8/B7RbtkrBrA8vV6z5d15HJ0Pb3bXOi23KF
         S/93fdBFmcVZB55vPDIKjTAPAnVUI/Qmyo7MXIxvyLk0lFmiJt8cQI+uyjAeBvuGFjj7
         CJKkvmsms6voty7AcGuwy9D9y+8VsG8bpBH82AOlubRehiaqNwhu5VGuAOsm6WVB8fy+
         z2kBLlp0hRFOikqXfdLtdJ0/kzwWjiZCCKCxdJSw5FEs5FZgaqWqVY8hHoGGNhvRFwpT
         CPTA==
X-Gm-Message-State: APt69E0r5PjjEHMRKzg6RXgsHxCjtiZ9SL3jYuFL8t+sHiyybMsaX1ZX
        s+xZ8583r8lxYSYi7CQBcPsL4vVb0GT4By1QCKdQMRWr
X-Google-Smtp-Source: ADUXVKLue/FrGPMlDAIEnlBXHnCR5j7eCcDrQfyl03s+b1/noQlC+7LSLGJ7fJkHD9VsNGRD4vfIggri5xK89sflljQ=
X-Received: by 2002:a19:8ecd:: with SMTP id a74-v6mr6989950lfl.12.1529322733434;
 Mon, 18 Jun 2018 04:52:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 04:52:12
 -0700 (PDT)
In-Reply-To: <f992c920-7e57-8099-b13c-f3651c0d1594@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-5-songjun.wu@linux.intel.com> <CAK8P3a0K6qezHLcjkeq0zd+iQJQc_qbT2JhtZGrCNRT495sUvQ@mail.gmail.com>
 <f992c920-7e57-8099-b13c-f3651c0d1594@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 13:52:12 +0200
X-Google-Sender-Auth: 0Kucv6JGWonQB_x2QIskA4_VNNA
Message-ID: <CAK8P3a3Zgtk56RAuP=J=-F9VPLxCu=vyGRFpTdBjtnWbOX+4KQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
To:     "Wu, Songjun" <songjun.wu@linux.intel.com>
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
X-archive-position: 64354
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

On Mon, Jun 18, 2018 at 11:39 AM, Wu, Songjun
<songjun.wu@linux.intel.com> wrote:
>
>
> On 6/14/2018 6:07 PM, Arnd Bergmann wrote:
>>
>> On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com>
>> wrote:
>>>
>>> Previous implementation uses platform-dependent functions
>>> ltq_w32()/ltq_r32() to access registers. Those functions are not
>>> available for other SoC which uses the same IP.
>>> Change to OS provided readl()/writel() and readb()/writeb(), so
>>> that different SoCs can use the same driver.
>>>
>>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>>
>> Are there any big-endian machines using this driver? The original
>> definition
>> of ltq_r32() uses non-byteswapping __raw_readl() etc, which suggests
>> that the registers might be wired up in a way that matches the CPU
>> endianess (this is usally a bad idea in hardware design, but nothing
>> we can influence in the OS).
>>
>> When you change it to readl(), that will breaks all machines that rely
>> on the old behavior on big-endian kernels.
>
> It will not break existing big-endian SoC as SWAP_IO_SPACE is disabled.
>
> Disable SWAP_IO_SPACE will not impact ltq_r32 as it uses non-byte swapping
> __raw_readl() and it makes readl work in big-endian kernel too.
>
> The old Lantiq platform enable SWAP_IO_SPACE to support PCI as it's a
> little-endian bus plus PCI TX/RX swap enable impacted both data and control
> path.

Right, I see now what you mean. I was getting confused by how MIPS
defines the __raw_* accessors differently from other big-endian
architectures when CONFIG_SWAP_IO_SPACE is disabled.

I suppose this just means you can't use any PCI drivers using __raw_
accessors or memcpy_fromio(), but your patch to the serial driver is fine.

> Alternatively PCI device driver has to do endian swap, It is better to let
> PCI device driver to do endian swap instead because SWAP_IO_SPACE is global
> wide macro.
> Once we set it, other peripheral such as USB has to change its register
> access as well

I'm not entirely sure what you mean here, I would assume that aiming for
maximum compatibility with existing drivers would be the main goal here.
The USB platform drivers can already deal with being compiled for either
(or both) endianess.

      Arnd
