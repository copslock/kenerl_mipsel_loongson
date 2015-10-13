Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 19:24:40 +0200 (CEST)
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35902 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006717AbbJMRYiYXX6V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 19:24:38 +0200
Received: by lfeh64 with SMTP id h64so282405lfe.3
        for <linux-mips@linux-mips.org>; Tue, 13 Oct 2015 10:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8vjRJJSybxLwBC/3rGNpsoBE5a/kGrNGWfBK3deBEio=;
        b=FQ5VvcvsFHQqx60INkH8NhmLhD37wyxnv7JFr0DZDjnffRAk9/p7JXU1cye5O1KpdQ
         ZytKQP2vckWJr/4kvdWZ9/67btuvFK4Am70+km72O+NHIrtqjYhPoM+pAEuTQPwXLxkS
         t+/aLqowDOoHceg5vEpvKtUCuiSulG4jFC7n5MjHWxlsv7oZuK3LloAnTIzLRGQ17d2Z
         catSAzJ465LcIZ7DAf4xd9xQXhMrtupTJ5v15smAOSWF0ttEXrOAtsqGWHaATlCWoZyc
         9Ti6+cool9tFURObBZLcRVsodWwVR7Pfa4N9hSqCrczoU2YGLbl0TavpSppKGrGPse0Y
         VDgg==
X-Gm-Message-State: ALoCoQmsR96Gn0lZTMOALrvhIi8izeOeg/RTA1tH7aap7s2vUw9yiTA33vUZ5D50vg737x2rhX9f
X-Received: by 10.25.213.8 with SMTP id m8mr10447514lfg.114.1444757071682;
        Tue, 13 Oct 2015 10:24:31 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-254-255.pppoe.mtu-net.ru. [83.237.254.255])
        by smtp.gmail.com with ESMTPSA id vz2sm673177lbb.35.2015.10.13.10.24.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 10:24:30 -0700 (PDT)
Subject: Re: [RFC v2 PATCH 00/14] Implement generic IPI support mechanism
To:     Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@imgtec.com>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1510131550020.25029@nanos>
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <561D3E4C.909@cogentembedded.com>
Date:   Tue, 13 Oct 2015 20:24:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1510131550020.25029@nanos>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49532
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

On 10/13/2015 04:53 PM, Thomas Gleixner wrote:

>> This series is based on Linus tree. I couldn't compile test it
>> because MIPS compilation was broken due to other reasons. I expect
>> some brokeness because of the introduction of struct irq_common_data
>> which is not present on the 4.1 tree I was testing my code on before
>> porting it to Linus tip. I will fix these issues and introduce
>> proper accessors for accessing struct ipi_mask given that the
>> concept is approved.
>
> Please base it on 4.1-rc5 + irq/core.

    On 4.3-rc5, you mean?

MBR, Sergei
