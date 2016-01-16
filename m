Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jan 2016 15:44:31 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36634 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008872AbcAPOo3wm31X convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jan 2016 15:44:29 +0100
Received: by mail-ig0-f178.google.com with SMTP id z14so29890928igp.1
        for <linux-mips@linux-mips.org>; Sat, 16 Jan 2016 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dAILR5Jrrg95RSnAqPjbPmmsFiaSdOeunqsha0X/JPw=;
        b=R1QgoaqIXrMJdQt7zpTs8Gq/rNaArmU6TY7htdoQ0uUSHamfA1vVsA/qvI0qehIdK2
         twuhvT+dqilTBeFMAcxUW0JqEVucuLXSKhZMmKeMzs9kzdMsj3L2Le8aURzzD2uKIW7e
         PT5YbsdN2Kw6N9s9Q1/XLDPXXl8rNTXLCDzSUH2v+oESAT8J+02Sp+ecej2p2JHSZrA1
         U2WeL0PYdsk/T5w59pQAqz30csxN8vg8WhsBBNk9ThTbTxmviap+dwsDWGnaQUYjC8DI
         HemwLs/Fv5OpBcnSVzke+5feFFjBj2x92g708ivuJ3SLylqHGGkhDI372yO94UdNRI+2
         Al+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dAILR5Jrrg95RSnAqPjbPmmsFiaSdOeunqsha0X/JPw=;
        b=Vwpny5TebPYGFNUSsvb/UVyqHmiuuqzP515/6IJMDKaGdFLnp7BitENbz3iqk1RRD/
         9LL0OqwYqzUns98Ll4jZxNlFnEmQSimcmMqngqmXfaKJnAq9qEF6waBYBA2eorH7GCmP
         pm2shOQ0xF1WhUpBMG5v5dsZRrUNpadyty7/xNh9GrN0tVuxPsijGrVw2Gl7hBfYx3s+
         rhDa8ie0FqcsjxPMkkz/O4sbL4a6o7eaYTNrVuawc8Z+yiivuh+q4UZKsmWmCSMGfjD3
         VVKMM+7fCiri2jpvgtkyrxcFE37OQU8mMMuntHHThFZAeLTdkV8t9Cbkx8Vmmcv0ovfV
         gXhA==
X-Gm-Message-State: AG10YOT/pIvpQsCT2GnGh9MeqPo32psPW9fEX21H7PU/yg+mheh6mFz27vytWUVN2J3xAZ/g37GCV1IZlJlNRA==
MIME-Version: 1.0
X-Received: by 10.50.138.76 with SMTP id qo12mr3669503igb.85.1452955464003;
 Sat, 16 Jan 2016 06:44:24 -0800 (PST)
Received: by 10.107.149.16 with HTTP; Sat, 16 Jan 2016 06:44:23 -0800 (PST)
In-Reply-To: <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
References: <8128014.DbbgBtKY3z@wuerfel>
        <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
        <4037550.DMaVTE01Aq@wuerfel>
        <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
Date:   Sat, 16 Jan 2016 15:44:23 +0100
Message-ID: <CACna6ryvDFHqwJ3ExURcyFT2ZaT9fS9v36wCnJfze5BLnE88og@mail.gmail.com>
Subject: Re: [PATCH, RESEND] ssb: mark ssb_bus_register as __maybe_unused
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Buesch <m@bues.ch>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 16 January 2016 at 13:10, Kalle Valo <kvalo@codeaurora.org> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> On Thursday 14 January 2016 08:46:29 Kalle Valo wrote:
>>> I can take it. For historical reasons ssb patches go through my
>>> wireless-drivers trees.
>>
>> I found this in my backlog, and I believe it still applies. Can you take
>> that one too?
>
> I'm not sure what you mean here, I can take any ssb patch if it's ok for
> Michael or Rafal :)
>
> Just please submit the patch properly (with S-o-B line) and CC
> linux-wireless so that it goes to patchwork.

It was already sent once and Acked by Michael:
https://patchwork.kernel.org/patch/7543191/

The problem was not cc-ing linux-wireless so it wasn't picked by the
linux-wireless patchwork.

-- 
Rafał
