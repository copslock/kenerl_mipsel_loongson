Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 16:39:03 +0100 (CET)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:36732
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdL1Piz6iRbd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 16:38:55 +0100
Received: by mail-ua0-x244.google.com with SMTP id a25so21013951uak.3;
        Thu, 28 Dec 2017 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q+BGJYSyv3LZBf8E72U1z/hjs4EYe6OnWMbmkiVnQJ0=;
        b=KK0rWaxxJtCn2KO+ZBLwFXqzbImJt/8mNuYJwURyACDTB1JQ4klkhr5u8Jkh7rkvCW
         MulbCu76CwxaJQ46mx4rR8Us6K4mUw/RR+Af8WTVvXXet3Y2C+aPk2bB/TbumrzK4DFZ
         iyRwdGLbNpWeN34RoBY9+13o13buR/k8GHVIiA+xTqKTkhF1jrXZ+4RSrLSwoeF4jhbi
         HRUJ5iNoYRoZSdzwJIn+c0S5jJCHAINgw1qlA9a1bXa+NRxpCGQxwPlV4NA1hcr5S9tx
         3NGQMfsDRPMTrWkAbNlTYqzvTd4CdTGEtIa9N2HkbdbKKr1LzreNGj2Umvzs9affe1dX
         5e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q+BGJYSyv3LZBf8E72U1z/hjs4EYe6OnWMbmkiVnQJ0=;
        b=CwAz/tpdtFe8LXm6xMzuSCErKAW/dNFZGr/Dbo+HRoBG7Y1rRSQxR72GPvl7lomSQj
         ANZfxlG5LFJlEblpREXCKf0fMzeDkANaHP+PQMfjnvlFE5gqz+Xf2O8HUO3wJANXUnhv
         xIW+9ZhyphklMzBxTyAmojusKlrgF1q0XBbKkXSWZ4+fc+7HCUBQuyYxwomN6rchzWg+
         mcQRoV7ZXHXN0cX2fwbBdnnNE0EzTOXt36V+YXP4Ii4eTk7fHWKWolh3aiArnnL2rJuE
         lyJm8PVyK8cvqk/KPPE2lCgfPNSSToWiQrM1/v+HVXtkFgmt7/JGgCaV/Vpn9+TJO6GO
         oMFw==
X-Gm-Message-State: AKGB3mJC0M4VT47sWw45xQ5z98djBQKluoPE9T+yX/v1h+fJF1OIF2Ku
        3xnNtqcZU34NmwECccpmwrNI16rsSMnwYIRi1fM=
X-Google-Smtp-Source: ACJfBov5L/CzLzNnELeeyIrC8CDcHxWnhATYvhIsrX1bnnWi3HLpmzwb+7elGpG8JTUpFDCCKqNvsNmfwX7iz6pZkqA=
X-Received: by 10.176.80.24 with SMTP id b24mr16815836uaa.187.1514475529705;
 Thu, 28 Dec 2017 07:38:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.2 with HTTP; Thu, 28 Dec 2017 07:38:29 -0800 (PST)
In-Reply-To: <20171114110211.GA5823@jhogan-linux.mipstec.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com> <20171029152721.6770-4-jonas.gorski@gmail.com>
 <20171114110211.GA5823@jhogan-linux.mipstec.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 28 Dec 2017 16:38:29 +0100
Message-ID: <CAOiHx==rL82D4NMz8t15jMr8m5oQmhkAzc+9r6qA0WMgbS-b9w@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] MIPS: AR7: ensure the port type's FCR value is used
To:     James Hogan <james.hogan@mips.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 14 November 2017 at 12:02, James Hogan <james.hogan@mips.com> wrote:
> On Sun, Oct 29, 2017 at 04:27:21PM +0100, Jonas Gorski wrote:
>> Since commit aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt
>> trigger I/F of FIFO buffers"), the port's default FCR value isn't used
>> in serial8250_do_set_termios anymore, but copied over once in
>> serial8250_config_port and then modified as needed.
>>
>> Unfortunately, serial8250_config_port will never be called if the port
>> is shared between kernel and userspace, and the port's flag doesn't have
>> UPF_BOOT_AUTOCONF, which would trigger a serial8250_config_port as well.
>>
>> This causes garbled output from userspace:
>>
>> [    5.220000] random: procd urandom read with 49 bits of entropy available
>> ers
>>    [kee
>>
>> Fix this by forcing it to be configured on boot, resulting in the
>> expected output:
>>
>> [    5.250000] random: procd urandom read with 50 bits of entropy available
>> Press the [f] key and hit [enter] to enter failsafe mode
>> Press the [1], [2], [3] or [4] key and hit [enter] to select the debug level
>>
>> Fixes: aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt trigger I/F of FIFO buffers")
>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>> ---
>> I'm not sure if this is just AR7's issue, or if this points to a general
>> issue for UARTs used as kernel console and login console with the "fixed"
>> commit.
>
> Thanks. Given nobody seems to have objected, I've applied to my
> mips-fixes branch, with stable tag for 3.17+.

Hmm, I don't see it in
https://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git/log/?h=mips-fixes
- did you maybe forget to push?


Regards
Jonas
