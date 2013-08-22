Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 22:41:27 +0200 (CEST)
Received: from mail-oa0-f48.google.com ([209.85.219.48]:54092 "EHLO
        mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867659Ab3HVUlWxqaXm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Aug 2013 22:41:22 +0200
Received: by mail-oa0-f48.google.com with SMTP id o17so4389401oag.7
        for <linux-mips@linux-mips.org>; Thu, 22 Aug 2013 13:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding;
        bh=YdDW6aWIqCVJwPTqIzFqzoPxTwCFbcw8FhZ1fsm6ips=;
        b=QVQQdOGJqHYAmC6aa3kmWY2/0v7vcpHF1olbS1xeRFQF4x6CXtHHy5y2AeryU8/6FM
         9P5xeQM1X9gFHXOTIL/PVfIupq1mwx0wCem1OcegugznxakFicF31CoFFL3ibhi+9Ikm
         kTa4ysdNSKO6CRaE4DDxn1rtkil32QdYkUHZ9XaVqkJ4DVeMBIXyQ8lFkFPqMHGGcnPK
         EVThr094QJdu0AIjn3hYscDasq5nPBs+9W3gmaGcAhANB/ECo88er+huSi0oF0zn5h7O
         FIGYvxQnO8uordDWCDw3FbFRx4wEVI4lpwmXQqsyvkYah/YMFFIACOkfv/GmlprtutHw
         bGdg==
X-Gm-Message-State: ALoCoQmoJprVipDAO7bMIf170Q7jMHtInT+8/6A3UhaTbhS8SvA/U5LuAmStqrNvoaGoOYPUsEXV
X-Received: by 10.60.131.3 with SMTP id oi3mr3349839oeb.104.1377204076618;
        Thu, 22 Aug 2013 13:41:16 -0700 (PDT)
Received: from driftwood (cpe-72-179-2-121.austin.res.rr.com. [72.179.2.121])
        by mx.google.com with ESMTPSA id ps5sm21269022oeb.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 13:41:15 -0700 (PDT)
Date:   Thu, 22 Aug 2013 15:41:09 -0500
From:   Rob Landley <rob@landley.net>
Subject: Re: [RFC] Get rid of SUBARCH
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Richard Weinberger <richard@nod.at>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Michal Marek <mmarek@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
        <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
        <20130821195157.GA18191@merkur.ravnborg.org>
        <CAMuHMdWqwQxxky7UDnh-oxN13C-sxfnxKVBuBz1GU_RtJvbf3A@mail.gmail.com>
In-Reply-To: <CAMuHMdWqwQxxky7UDnh-oxN13C-sxfnxKVBuBz1GU_RtJvbf3A@mail.gmail.com>
        (from geert@linux-m68k.org on Thu Aug 22 07:58:26 2013)
X-Mailer: Balsa 2.4.11
Message-Id: <1377204069.2737.108@driftwood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 08/22/2013 07:58:26 AM, Geert Uytterhoeven wrote:
> On Wed, Aug 21, 2013 at 9:51 PM, Sam Ravnborg <sam@ravnborg.org>  
> wrote:
> >> > The series touches also m68k, sh, mips and unicore32.
> >> > These architectures magically select a cross compiler if ARCH !=  
> SUBARCH.
> >> > Do really need that behavior?
> >>
> >> This does remove functionality.
> >> It allows to build a kernel using e.g. "make ARCH=m68k".
> >>
> >> Perhaps this can be moved to generic code? Most (not all!)  
> cross-toolchains
> >> are called $ARCH-{unknown-,}linux{,-gnu}.
> >> Exceptions are e.g. am33_2.0-linux and bfin-uclinux.
> >
> > Today you can specify CROSS_COMPILE in Kconfig.
> > With this we should be able to remove these hacks.
> 
> The correct CROSS_COMPILE value depends on the host environment, not
> on the target configuration.

Actually it depends on _both_.

Rob
From ddaney.cavm@gmail.com Thu Aug 22 22:55:31 2013
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 22:55:34 +0200 (CEST)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36224 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867665Ab3HVUzb0lzMN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Aug 2013 22:55:31 +0200
Received: by mail-ob0-f169.google.com with SMTP id wc20so4736149obb.28
        for <multiple recipients>; Thu, 22 Aug 2013 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KnhN6jVTfBh15tGqs3VVEHUPdCxgHMF/Vfm52t7+1jk=;
        b=k91e7ySU6KDxw9nYWhu4nmNqCbTWgICsK+ltLMV0Q03rLNx28C/DKXR9kgsfQiswv1
         If5W+pj6Lyp+d21cQlRJwEKuv/AJ6b37XUpqOnVgazXtYpRZLukmroH+QfsgEsurBsYD
         +T2P8XGSfbqKmKhqUhhmiMVLenkdaHsufh2C7TP9leWDSyNftkCcAy9fVYXPmnQLSZPU
         SbpkDlIeZdyi+7hAisk7asTa0hH6at/aYxhk+axtdk/CNReUhBtFkFrP33gW7IJmACmZ
         8FBgEoriwzk2srtQWNOZZVJxlvSvhRu74P/HSSaY7qMaPPAysUHfwJJij2tWoL6xkzR1
         +wbQ==
X-Received: by 10.50.47.20 with SMTP id z20mr6805972igm.34.1377204924737;
        Thu, 22 Aug 2013 13:55:24 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p5sm7084247igj.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 13:55:23 -0700 (PDT)
Message-ID: <52167AB8.4060206@gmail.com>
Date:   Thu, 22 Aug 2013 13:55:20 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Rob Landley <rob@landley.net>, Richard Weinberger <richard@nod.at>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Michal Marek <mmarek@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [RFC] Get rid of SUBARCH
References: <1377073172-3662-1-git-send-email-richard@nod.at>        <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>        <20130821195157.GA18191@merkur.ravnborg.org>        <CAMuHMdWqwQxxky7UDnh-oxN13C-sxfnxKVBuBz1GU_RtJvbf3A@mail.gmail.com> <1377204069.2737.108@driftwood>
In-Reply-To: <1377204069.2737.108@driftwood>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37650
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
Content-Length: 1375
Lines: 36

On 08/22/2013 01:41 PM, Rob Landley wrote:
> On 08/22/2013 07:58:26 AM, Geert Uytterhoeven wrote:
>> On Wed, Aug 21, 2013 at 9:51 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> >> > The series touches also m68k, sh, mips and unicore32.
>> >> > These architectures magically select a cross compiler if ARCH !=
>> SUBARCH.
>> >> > Do really need that behavior?
>> >>
>> >> This does remove functionality.
>> >> It allows to build a kernel using e.g. "make ARCH=m68k".
>> >>
>> >> Perhaps this can be moved to generic code? Most (not all!)
>> cross-toolchains
>> >> are called $ARCH-{unknown-,}linux{,-gnu}.
>> >> Exceptions are e.g. am33_2.0-linux and bfin-uclinux.
>> >
>> > Today you can specify CROSS_COMPILE in Kconfig.
>> > With this we should be able to remove these hacks.
>>
>> The correct CROSS_COMPILE value depends on the host environment, not
>> on the target configuration.
>
> Actually it depends on _both_.
>

I think the important issue is not the exact dependencies of the value 
of CROSS_COMPILE, but rather that it varies enough that automatically 
choosing a value based on SUBARCH often gives the wrong result.

Removing SUBARCH and setting CROSS_COMPILE either from the make command 
line (or environment) or the config file, is a good idea because it 
simplifies the build system, makes things clearer, and yields more 
predictable results.

David Daney
