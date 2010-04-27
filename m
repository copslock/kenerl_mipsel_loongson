Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2010 10:24:35 +0200 (CEST)
Received: from mail-bw0-f218.google.com ([209.85.218.218]:64724 "EHLO
        mail-bw0-f218.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491831Ab0D0IYc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Apr 2010 10:24:32 +0200
Received: by bwz10 with SMTP id 10so12181921bwz.24
        for <linux-mips@linux-mips.org>; Tue, 27 Apr 2010 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RUgwB2LQ8e3mjguEKqHW5dw3TfqVTjuaFx1p4Bv4xKo=;
        b=hQfVD03lNUY07caH2W1crykz4kwYbNn9L6IXj+OaMDBqEBGNLduPg4l9tRrIsWMm/B
         H9nT74yjoa5IAG+sVJEdyaLffs5gBRLcDSjVSA/qEMmD3otzG4tV3q44Kv9jfSFqQ6iv
         6zTfFA62gI4O+7YkAHVG1jajOCZXUd966sXbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xkHxf1Pyw3AQWdaXiRLB6ZF6pxdg/vHOza56gvQ/tEvCc+/bx7GofcakSktukqEOnH
         AQ5F0QYDZNPnjkYAN/BGrRuSNpKMLrGEMhefS1SLsEOzcc/vdLrWz7gn6ZPfUxT0boEr
         CxEgiATUuStwNZPt4HlKICOLhZ0SrjX3vTUdY=
Received: by 10.102.15.22 with SMTP id 22mr2993040muo.7.1272356665100; Tue, 27 
        Apr 2010 01:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.177.13 with HTTP; Tue, 27 Apr 2010 01:24:05 -0700 (PDT)
In-Reply-To: <4BD5C7F8.6050406@caviumnetworks.com>
References: <l2p417f50831004260640o684d0f8fgf6a3aa60450e329c@mail.gmail.com> 
        <4BD5C7F8.6050406@caviumnetworks.com>
From:   "Giant Sand Fan's" <rampxxxx@gmail.com>
Date:   Tue, 27 Apr 2010 10:24:05 +0200
Message-ID: <l2u417f50831004270124p78b5af38m724ae5e37dd43de@mail.gmail.com>
Subject: Re: Cavium mips64 perf counters
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <rampxxxx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rampxxxx@gmail.com
Precedence: bulk
X-list: linux-mips

0h, thank you David.

So can I do something like :

A.-) %CPU == (LOG_PERF_CNT_SISSUE)+(LOG_PERF_CNT_DISSUE*2)*100/CVMX_LOG_PERF_CNT_CLK

or

B.-) %CPU == (CVMX_LOG_PERF_CNT_ISSUE*100)/CVMX_LOG_PERF_CNT_CLK


I setup and read perf counters with :

mtc0 %0, $25, 0
dmfc0 %0, $25, 1

but I think that I can only read two counters so I can only use "B".

... or I'm totally wrong



2010/4/26 David Daney <ddaney@caviumnetworks.com>:
> On 04/26/2010 06:40 AM, Giant Sand Fan's wrote:
>>
>> Hi,
>>
>> I'm trying to calculate de CPU load by access the performance counters
>> in mips and I haved reading in the cp0 but my problem is that I cannot
>> find documentation about the real meaning of these counters :
>>
>> 1.-LOG_PERF_CNT_NISSUE : żmeans cycle with no issue?
>>
>> 2.-LOG_PERF_CNT_SISSUE : żmeans cycle with     issue?
>
> Single issue.
>
>>
>> 3.-LOG_PERF_CNT_DISSUE: żmeans cycle with double issue?
>>
>
> That's right.  And PERF_CNT_CLK is the number of cycles.
>
> David Daney
>



-- 
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html
