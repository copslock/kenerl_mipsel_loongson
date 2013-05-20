Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 20:58:28 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40669 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824104Ab3ETS61Av4Bt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 20:58:27 +0200
Received: by mail-pd0-f176.google.com with SMTP id r11so2342340pdi.7
        for <multiple recipients>; Mon, 20 May 2013 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=enGGGXO68Neo0S4nkl7LRA1fqdLAuc86X2BilSccQWU=;
        b=CWCxNOl0zXtskgSCZPEcE12ifvmxQyYeEpqyQR/VOv8wqpgYH8m6MsxijoLqUjmrXo
         EdytXosgzxYAGQrthvZ3YDXIihDOc1OslpU05mWVwoRm5j7osuVSABhDVns2JmMG4IQS
         dNg/yl56TadI76szv0hkgtcfag0mXKQ9Yk6oFZ3dAVRQFbRzfvFVaokLCil2ZvhUIoMZ
         BVBr5vMtTizktwZtf5NppcxUSBkv4ZCN2W080oTosYSq+5PHSqWBa+wHzTWJ6EFqhtOv
         0adyPTAZa4vj3ekAc964ruYykMd5A9sx5q+8XqrpvxrOkKkB9Riv7WeJhfOP2q5XUDWS
         EdLg==
X-Received: by 10.66.250.131 with SMTP id zc3mr44044667pac.157.1369076300049;
        Mon, 20 May 2013 11:58:20 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id xl10sm26896317pac.15.2013.05.20.11.58.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 11:58:19 -0700 (PDT)
Message-ID: <519A7249.1030302@gmail.com>
Date:   Mon, 20 May 2013 11:58:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 00/18] KVM/MIPS32: Support for the new Virtualization
 ASE (VZ-ASE)
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <519A4640.6060202@gmail.com> <456B70C6-A896-4B94-B8EF-DE6ED26CE859@kymasys.com> <alpine.LFD.2.03.1305201930570.10753@linux-mips.org>
In-Reply-To: <alpine.LFD.2.03.1305201930570.10753@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36488
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

On 05/20/2013 11:36 AM, Maciej W. Rozycki wrote:
> On Mon, 20 May 2013, Sanjay Lal wrote:
>
>> (1) Newer versions of the MIPS architecture define scratch registers for
>> just this purpose, but since we have to support standard MIPS32R2
>> processors, we use the DDataLo Register (CP0 Register 28, Select 3) as a
>> scratch register to save k0 and save k1 @ a known offset from EBASE.
>
>   That's rather risky as the implementation of this register (and its
> presence in the first place) is processor-specific.  Do you maintain a
> list of PRId values the use of this register is safe with?
>

FWIW:  The MIPS-VZ architecture module requires the presence of CP0 
scratch registers that can be used for this in the exception handlers 
without having to worry about using these implementation dependent 
registers.  For the trap-and-emulate only version, there really is no 
choice other than to re-purpose some of the existing CP0 registers.

David Daney
