Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 May 2013 23:07:59 +0200 (CEST)
Received: from mail-oa0-f52.google.com ([209.85.219.52]:35322 "EHLO
        mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827465Ab3EMVH6V7fGc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 May 2013 23:07:58 +0200
Received: by mail-oa0-f52.google.com with SMTP id h1so8277608oag.11
        for <multiple recipients>; Mon, 13 May 2013 14:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xlcaDKOT+vKvai60lkOax1IXhQmSviCZrcHgOmSxXYw=;
        b=S4zThYEwOG/o6GyAro5fWzvEwazSnyuyZxBZsF/DgZmGdWYNiQOl2Pkfh0hDUX+cau
         eWZHoNnWJgzo6hNg1+KB0KKnV/J/sjUoE7S37SAIpP/PCxsmLNEA7/LyHgoDlV7Bam3V
         z61njwMC8r2Iw3+TK/BH+L53kFkUrugWHH92E9393fm3U2wSTnlhqeEnM4DnD0EdZFzb
         Qic1u/5jQpWNLKs/oYYxUqFySXFeY2JoTjAQpcxtrm2258j2Y+O3u8hATkm69tnzlkWi
         T+NffQKvjM3HaUUpen+ZUUA4C3NczKsJKzQUCj+i18AWK3r/CU+GaP3ZbrmGChVBDbFi
         je5g==
X-Received: by 10.60.33.167 with SMTP id s7mr2949522oei.86.1368479272016;
        Mon, 13 May 2013 14:07:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nt17sm18102328obb.13.2013.05.13.14.07.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 14:07:51 -0700 (PDT)
Message-ID: <51915624.4010104@gmail.com>
Date:   Mon, 13 May 2013 14:07:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org, gleb@redhat.com,
        mtosatti@redhat.com, ralf@linux-mips.org
Subject: Re: [PATCH 0/2] KVM/MIPS32: Fixes for Linux 3.10
References: <n> <1368476500-20031-1-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1368476500-20031-1-git-send-email-sanjayl@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/13/2013 01:21 PM, Sanjay Lal wrote:
> The following patch set fixes a couple of issues with KVM/MIPS32 in Linux 3.10.
>
> - As suggested by Gleb, wrap calls to gfn_to_pfn() with srcu_read_lock/unlock().
> - kvm_mips_map_page() now returns an error code to it's callers, instead of calling panic()
>    if it cannot find a mapping for a particular gfn.
> - Follow the latest convention and move the kvm.h API file under uapi/...
>

Sanjay,

Have you looked at:

http://www.linux-mips.org/archives/linux-mips/2013-05/msg00049.html

We should start working toward unifying the KVM interface.

David Daney.


> --
> Sanjay Lal (2):
>    KVM/MIPS32: Move include/asm/kvm.h => include/uapi/asm/kvm.h since it
>      is a user visible API.
>    KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()
>
>   arch/mips/include/asm/kvm.h      | 55 ----------------------------------------
>   arch/mips/include/uapi/asm/kvm.h | 55 ++++++++++++++++++++++++++++++++++++++++
>   arch/mips/kvm/kvm_tlb.c          | 38 ++++++++++++++++++++-------
>   3 files changed, 84 insertions(+), 64 deletions(-)
>   delete mode 100644 arch/mips/include/asm/kvm.h
>   create mode 100644 arch/mips/include/uapi/asm/kvm.h
>
