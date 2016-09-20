Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 12:55:46 +0200 (CEST)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33657 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992161AbcITKzjWArzp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 12:55:39 +0200
Received: by mail-lf0-f52.google.com with SMTP id h127so10119693lfh.0
        for <linux-mips@linux-mips.org>; Tue, 20 Sep 2016 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Dxw1VreMsjlxGeM8Xittww1z+zfWnjwsfLFlD0MiOt8=;
        b=bXyAENf5nVQM9+ZuDSL04vSlAcZrC6olbZnHOA2T0oYCX3EOPRZzvVSV3abz8lQndk
         ReCvQEv+N4k4HOJSJIISi4pSnZiIRvR4x1TO1VacdUtMBwuo4mvmmTTRQ5jI6LL0mMtV
         yLE8uxACcaRMSQ8+LtZmZi/AM/sZZQvKyjOSuEuguUYCPGr6KA6W6A7I3y+xpb07ldNI
         Zj9JIt9MDsfI/qGs44yzu80YTJKIqoYUmEni91MsK2ESmHG6q8A4OcW6CA0IUaLPn97n
         wUNGwZAi0+LxFoxXvFB3i0iImyDrdibU79r21NNnYFv69MQXD0p7y8v9gafoa5HHcG3x
         vedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Dxw1VreMsjlxGeM8Xittww1z+zfWnjwsfLFlD0MiOt8=;
        b=RLV4AGHyyiQE2xsXyFgX6k31SNaPZWucSxa0iiw4KCggDF+9B5k9ys5EghWatrXvqC
         zLABAEWg7e+ykuBcrbZuZDu1FaFrXh9SOOxPX70lhPINr+60MK5HVfFt4lFD+4zsWYSz
         747KSIm1wNrr0RbByuvkuQG06EYopcB0Y/F2oLFFaaJquO2Vipq9fWeQBn2Hi0k/ausS
         Sg/I745TVt29GHsRLSyjPBctsq2ILlU2OKBt/8hMRrWMfVLQAu4XUbsdgn0BaNe+V3p6
         zQW/rUUwfpcd3BnfkVCBfcMMqq5JPM9v76271omD8LpOWUHeHMuEaJdLOlgjXnx+2tZd
         TV7w==
X-Gm-Message-State: AE9vXwMVxY1ju7EVlgt61ZuGEUvilK2Znp8WtW3TtTLAowkAljR+lgJc1xsNeo+RpoQPdw==
X-Received: by 10.25.27.139 with SMTP id b133mr11394213lfb.157.1474368933684;
        Tue, 20 Sep 2016 03:55:33 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.85.178])
        by smtp.gmail.com with ESMTPSA id p128sm5739835lfb.32.2016.09.20.03.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2016 03:55:32 -0700 (PDT)
Subject: Re: [PATCH v2 09/14] MIPS: Malta: Probe RTC via DT
To:     Paul Burton <paul.burton@imgtec.com>
References: <20160919212132.28893-1-paul.burton@imgtec.com>
 <20160919212132.28893-10-paul.burton@imgtec.com>
 <55c977d1-21dd-4cf8-d0f9-10d96b452573@cogentembedded.com>
 <762c9f70-911c-0e48-ef8e-8f8b9e006592@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <fa83f27d-f7c0-60ee-a8f8-62f4af9af05a@cogentembedded.com>
Date:   Tue, 20 Sep 2016 13:55:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <762c9f70-911c-0e48-ef8e-8f8b9e006592@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55205
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

On 9/20/2016 1:34 PM, Paul Burton wrote:

>>> Add the DT node required to probe the RTC, and remove the platform code
>>> that was previously doing it.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - Remove rtc DT node label
>>
>>    Haven't you also renamed the node?
>
> Hi Sergei,
>
> Yes, strictly speaking I could have been more verbose & elaborated in
> the changelog on every aspect of the simple change from "rtc:
> mc146818@70" to "rtc@70". I didn't, but as it's obviously clear to you
> what changed and it has no effect on either the code or the commit that
> would end up in git I don't really see the point of your bringing it up.

    It may be obvious to me (since it was my comment that you addressed here) 
but not to others... Perhaps I'm too captious indeed, sorry about that. :-)

MBR, Sergei
