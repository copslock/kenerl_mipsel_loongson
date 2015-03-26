Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 03:12:39 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34680 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008271AbbCZCMhN8Id2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 03:12:37 +0100
Received: by iedfl3 with SMTP id fl3so41097610ied.1;
        Wed, 25 Mar 2015 19:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=toTb8p0+mRPDuZpFH+9abaQDDvLy81xRaBO87depZqs=;
        b=lYPLKMCg5JlK2aLZTl16Ovd6T7mOytXJvTm409XYsDCEuSJFbuXUvPJuXssQF0xhtA
         n/0cdo+NmSmFyb5KMiRdMktjGfSE0WUC0pCAaIBow5U/dPbaLwuqDvq7MJBSoD507e+E
         Hdy5KfE+vnBm4OYaTbqKCIzOFkP+lRIS05pH+9G7k/lbJdovpdOqzsXNy0TnMysPMcjK
         n1pA0M3JC8Wxh39oC9t/MAKXx/9s+E9QFVXK7JOwtALU4RryA54kRsLn5mM6CQeUZj5Q
         5rCuwKwAOhe84meGh7SoMdNpo7jPZhYAqIeRAM9W3CZTS8clA25stYLKwQoQ9x4Rl4GV
         2WdQ==
X-Received: by 10.107.27.143 with SMTP id b137mr17878895iob.76.1427335952293;
 Wed, 25 Mar 2015 19:12:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.41 with HTTP; Wed, 25 Mar 2015 19:12:12 -0700 (PDT)
In-Reply-To: <20150325180927.GI1385@linux-mips.org>
References: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
 <CAAVeFuLytDZwo-=Q3DSxS7jLWbr4Jgf8BsBr9VGptBBu4SzZZg@mail.gmail.com>
 <CAAhV-H5i+ysaJi1=6ftyY_82yGBZnCqpUmCV2ayMVMDFw0uWVQ@mail.gmail.com>
 <CAAVeFuLF7tHgqXbX1MAikM67DwSu729eG0JcBiipSAG=AeBfOQ@mail.gmail.com> <20150325180927.GI1385@linux-mips.org>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Thu, 26 Mar 2015 11:12:12 +0900
Message-ID: <CAAVeFuLb7TOYfG_L7PBmAVAFEVeybCSU19W+_j2WZLF-Q5qNow@mail.gmail.com>
Subject: Re: [PATCH V8 3/8] MIPS: Cleanup Loongson-2F's gpio driver
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Huacai Chen <chenhc@lemote.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

Thanks Ralf!

Huacai, since these 3 patches are standalone, would you mind
re-sending them in their own series to Linus Walleij, myself and the
linux-gpio list along with Ralf's ack? It will improve their
visibility and make it easier to merge them. I will give my ack/review
tag on this new series.

Thanks!

On Thu, Mar 26, 2015 at 3:09 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Mar 25, 2015 at 11:19:01AM +0900, Alexandre Courbot wrote:
>
>> On Wed, Mar 25, 2015 at 10:15 AM, Huacai Chen <chenhc@lemote.com> wrote:
>> > I think these three patches can go to GPIO tree, because it has no
>> > relationship with others in this series.
>>
>> In that case we would need a ack from the MIPS maintainers to move the
>> code into drivers/gpio/.
>
> Yes, please.  For all three patches:
>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>
>   Ralf
