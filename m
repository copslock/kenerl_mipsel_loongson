Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 May 2017 11:30:42 +0200 (CEST)
Received: from mail-vk0-x232.google.com ([IPv6:2607:f8b0:400c:c05::232]:34927
        "EHLO mail-vk0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdEYJaf0S12Q convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 May 2017 11:30:35 +0200
Received: by mail-vk0-x232.google.com with SMTP id h16so88464261vkd.2;
        Thu, 25 May 2017 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uOtE+uVSbJjBqjrObZGV3VbNmGuY74IVQWQ0UGxOGQg=;
        b=WhFC/fizxHc7+mKmjMBNlp4dEiktYtIpQ6/poSH5Q5xojkQunjPxGQ9jRc2piHKY5f
         8usaMv90kHEIY+xAaOUjA/ZJJgNQVR0Vj1tsyxAtXlPzOs5aScsKfNBFgoE6KjZoGSNv
         Pu6mxr3vMbTy8DLpjx3KwRp0LQeVBWJc3tOZLlndw5WzvLe6dvbAMV8/1S/8vjz9fTxg
         rGjPRI2IwlQn0nPwxKbpaHr3GidQdihp5BPgveMFFKX+SOivJUEvl8MSt+3pAz37JIhd
         8NgUMjt7sdcKTAETemR5dhFhkTKynOaB4aH/D6YDUL4Uo/hIJmXws5CkSe9ysNOzHK1o
         cN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uOtE+uVSbJjBqjrObZGV3VbNmGuY74IVQWQ0UGxOGQg=;
        b=kaYcNRmiGu4SryHIi1nH2RTryUGnnVn1xEp1dsui8utoUl7nbxLF9pGiqqYTbSKTzp
         nAPprW+AXcgkjjSk+fBgYTFiiYIqz4m0Qwun1HZ1BpusggNCKC+FL2ZTgWEuEyIo0LXf
         zvY3wFIKOzKtSN1NTpeK9KUC/oSfzDKHLipLRdzK7fRdJF5j+gfMQkwAs1Bqwj0xSi7q
         DmGyTVHCfeVE8q7XBNTbP5iGtcapD2LKvasouNAp64VuKR3BKf3vSdHmG7DDGZW/MCOB
         wKNA3wIuzrG2tOyTGiDePrSBIHWpgZdff1eNQPpwVJceKKGHiuEeQqOreJskdCx2OdTd
         g0dA==
X-Gm-Message-State: AODbwcD0q6cy+D4SVCD6iTU8F/y557YQFyJKxROpNLrJzRkw5VrTEhhn
        1hnpZuUGAAi56n7kQ3p9w+1qujazJw==
X-Received: by 10.31.229.7 with SMTP id c7mr16835417vkh.105.1495704629738;
 Thu, 25 May 2017 02:30:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.68.135 with HTTP; Thu, 25 May 2017 02:29:49 -0700 (PDT)
In-Reply-To: <70394897-a67a-2b49-2d46-a20fb2de51f2@users.sourceforge.net>
References: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
 <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com>
 <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
 <CAOLZvyH-DF_r77kzcVcn+A-tTov+aNZ1oGNQLnGWXE35UODqtQ@mail.gmail.com> <70394897-a67a-2b49-2d46-a20fb2de51f2@users.sourceforge.net>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 25 May 2017 11:29:49 +0200
Message-ID: <CAOLZvyGEzzQ_Jvy3NNQqDER4QHe2Dj-Y4sX2MNANo-phXbzQ8g@mail.gmail.com>
Subject: Re: MIPS: Alchemy: Delete an error message for a failed memory
 allocation in alchemy_pci_probe()
To:     SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?B?UmFsZiBCw6RjaGxl?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Thu, May 25, 2017 at 8:54 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> How do you think about to achieve a small code reduction also for this software module?
>>
>> Generally speaking, sure.
>
> Thanks for your interest in such a direction.
>
>
>> But why remove just this one?  Is it because it loosely follows a
>> pattern that was deemed removable in that slidedeck you linked to?
>
> I derived another source code search approach from the implementation
> of the check “OOM_MESSAGE” in the script “checkpatch.pl” for
> the semantic patch language (Coccinelle software).
> The involved search patterns are still evolving and the used lists
> (or regular expressions) for function names where it might make sense
> to reconsider the usage of special logging calls is therefore incomplete.
>
>
>> (the "usb_submit_urb()" part)?
>
> Would you like to extend the function selection for further considerations?
>
>
>>> Do you find information from a Linux allocation failure report sufficient
>>> for such a function implementation?
>>
>> Yes, I wrote that code, and in case this driver doesn't load, I'd like
>> to know precisely where initialization failed.
>> I can happily spare a few bytes for that.
>
> Does this kind of answer contain a bit of contradiction?
>
> * Why do you seem to insist on another message if information from a Linux
>   allocation failure report would be sufficient already also for this
>   software module?
>
> * Do you want that it can become easier to map a position in a backtrace
>   to a place in your source code?

Does kmalloc() nowadays print a message which invocation (source line) failed?
If so I won't be standing in your way, but if not, you need to come up with
something for convincing than answering questions with more questions.

Manuel
