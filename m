Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Oct 2015 13:13:46 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36762 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008655AbbJQLNol4UqM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Oct 2015 13:13:44 +0200
Received: by lbcao8 with SMTP id ao8so114982145lbc.3
        for <linux-mips@linux-mips.org>; Sat, 17 Oct 2015 04:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8TJe3H75q+WILrSq/VA0CNCSBJq2u4mgvXtNSwPER3E=;
        b=CdjG021sou/Cr4ty1Nd4L7NzKxfIr3PtOMm3PACelafwsTvYX2cA0jqZf0NYlINwhM
         fHIfTKLVPcz6MKP/xfHiDGRrG0u9UVu5K1KqOKVfhW7qpdYDOcepr8n6CpSKBkdYfQvK
         DhVTuK87pIKEkQWN7+ZQ6XmYDm4KqteziXCyC6rD+Qp2fOGAPYOVxIB/IqHjHJyE3kkS
         VjZnT/te32Q3QR28sb7JUJKA9SpowNeszgA5/jdaY2ujdOxHljDJBExyx7XHt/IvuFJL
         GSrowitnIyfyUVkw/bvcmjfnj4QYSFzkv5o2efXUeiDqj2Bw6ja0StQhiSOWV4bU+enS
         gzoQ==
X-Gm-Message-State: ALoCoQnd2PCoo9rw7rOk/nHl1f3DktAkiDlRaibnHXPUK7NIzuA2Nj042qTlDcDQfS4AiVkwfoWN
X-Received: by 10.112.171.10 with SMTP id aq10mr10233321lbc.85.1445080416964;
        Sat, 17 Oct 2015 04:13:36 -0700 (PDT)
Received: from [192.168.3.154] (ppp83-237-251-24.pppoe.mtu-net.ru. [83.237.251.24])
        by smtp.gmail.com with ESMTPSA id ar7sm3560862lbc.24.2015.10.17.04.13.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Oct 2015 04:13:36 -0700 (PDT)
Subject: Re: [PATCH v2] MIPS64: signal: n64 kernel bugfix of MIPS32 o32 ABI
 sigaction syscall
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, paul.burton@imgtec.com, richard@nod.at,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        luto@amacapital.net, alex.smith@imgtec.com,
        markos.chandras@imgtec.com
References: <20151017002553.7002.69013.stgit@ubuntu-yegoshin>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56222D5F.5080601@cogentembedded.com>
Date:   Sat, 17 Oct 2015 14:13:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151017002553.7002.69013.stgit@ubuntu-yegoshin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 10/17/2015 3:25 AM, Leonid Yegoshin wrote:

> MIPS32 o32 ABI sigaction() processing on MIPS64 n64 kernel was incorrectly
> set to processing aka rt_sigaction() variant only.
>
> Fixed.
> --
> v2: Taken in account CONFIG vars interdependencies and conditional expression
>      simplified. As a result, the reverse problem fixed (introduced by v1).
>      Tested on all 3 ABIs.
> --

    You forgot to sign off this time.

[...]

MBR, Sergei
