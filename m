Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 21:58:41 +0200 (CEST)
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33555 "EHLO
        mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012909AbbERT6fO60Oq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2015 21:58:35 +0200
Received: by qgde91 with SMTP id e91so28079752qgd.0
        for <linux-mips@linux-mips.org>; Mon, 18 May 2015 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YkRsuVZL+T1MqZ2mle38tzCWWWwzh53HGyxCHQ+Ck/M=;
        b=oq1ekCBapMLsltRDUfd/LjxurglIoDJyuKA1UQHkxg9SOU+6YSOaS8dkH0eb/AdJjD
         aoGkHaeb97/D9y6fnJvnslQ0jDSNl6WkwODMlx5YUUAmoup3Ng3ILPX7G3DrJSZM2VnD
         a/DGoSjK/rkgp29XF3yNmgvzV5nc2e9WO8vSQjQAg53I4Y7oeR7Dsm6Q4gUdyLGIG7V3
         DSS4GhGceZgCUbFwl4bwYzReFGzn4CK1Kp4ugYGNCtIihdDnUr223dXqVCQzE5lxIeXW
         CO4lr/OASCkIjm93ZSEOqEe29UimPxodKQ7rLZSUsHxE7Y64REORs5zi4ZN7pSptjy3y
         g/eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YkRsuVZL+T1MqZ2mle38tzCWWWwzh53HGyxCHQ+Ck/M=;
        b=HGXjTw854sR15xmpbr4o9st25g2kwe6y3h/xtbUX1Yvkxm/sNIOW19tc1LZUT1/zZ9
         UoXGyAwL5KmCPF2aLDFkmDpqcK3ayubSILbDrPMdijLHSlyxYPVCSDb6TI532bMBShfE
         nTRYVot1zMPZSLxSXnbiY6NUKFm3cHCJ0mqc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YkRsuVZL+T1MqZ2mle38tzCWWWwzh53HGyxCHQ+Ck/M=;
        b=TsmSiJptjEdPW/w9f5Zjg9jpmIp9JdAKbziV44RmGGsrcS/i9q5ofxMmP8X2+UNcyt
         jWjWQyDmbIMzpIx0jpAcyiAXneRIEqn7+rU7kpwyyKwQeBImzhZMdRBtHMWmbqApFLOb
         O5fzcLT97rC/pj2XhcvS7btKmLsZmSHyOLkDfjNt6UojBkVkgTx20dmpO0jCxzJt3yY5
         v+65BOOVwvbSRMRPJ/doQv47dekLWPhXYq+Sr7vMsF5/qThB+E6NDFNLEKnkdKkZBIQH
         qU20FA2DnkD1qNgDOJ/lokQfbxElHXRxD/fqgBIynSV+zP/MIuKoTy8K877jUUfko2lt
         aw5w==
X-Gm-Message-State: ALoCoQmz6AKS4LvrKePtmhu1ScDxuBlEFCZo5/Aw8KLRB9TRBF1IRgYwzjvD0wpv9bSsq2xodShT
MIME-Version: 1.0
X-Received: by 10.140.100.164 with SMTP id s33mr21492212qge.36.1431979111028;
 Mon, 18 May 2015 12:58:31 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Mon, 18 May 2015 12:58:30 -0700 (PDT)
In-Reply-To: <5550C06D.2010409@ti.com>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
        <CAL1qeaE0+aMLBgk8SKgJ3fXm==M2-Z_yEPYNVZ0yxSee-p7YOw@mail.gmail.com>
        <5549083F.8080505@imgtec.com>
        <5550C06D.2010409@ti.com>
Date:   Mon, 18 May 2015 12:58:30 -0700
X-Google-Sender-Auth: YTvoN8MX7W5dw64kPbTaBmtAjHY
Message-ID: <CAL1qeaGuFdLNKjtiMjObLwRBDWY9zq0XQr+ptrVKgibe56SQQA@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Pistachio USB2.0 PHY
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andrew Bresticker <abrestic@chromium.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Mon, May 11, 2015 at 7:45 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Tuesday 05 May 2015 11:43 PM, Ezequiel Garcia wrote:
>>
>> Hi Kishon,
>>
>>>
>>> This series adds support for the USB2.0 PHY present on the IMG Pistachio
>>> SoC.
>>>
>>> Based on mips-for-linux-next and tested on the IMG Pistachio BuB.  If
>>> possible,
>>> I'd like this to go through the MIPS tree with Kishon's ACK.
>>>
>>
>> Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>
>> Can we have your Ack for this series so Ralf can pick it?
>
>
> sure..
>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Ralf, could you pick up this series for 4.2?

Thanks,
Andrew
