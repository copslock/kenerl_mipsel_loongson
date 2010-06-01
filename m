Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 21:07:22 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:57326 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492149Ab0FATHT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 21:07:19 +0200
Received: by fxm15 with SMTP id 15so4079039fxm.36
        for <linux-mips@linux-mips.org>; Tue, 01 Jun 2010 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=/Qne7c1E9MrAkSZGGbOvmMoJ/+iV3DxXGMyXupWTWOI=;
        b=T5X0a+9f/nuIUrs00Olb1Kloa4JdSZFkeiYoqR/hfhPQHxj9Y7P7Ba9y/RArRRJ5hF
         yRQb7HghYX44gh2Y5jUA93pL3kPbSglpq0A4fgpsaPRulTzSs/DWEuDjnXRKo15cE0dF
         0rIYEcp5QxHeGEGjDBDW1Agx2Rbs2vj032jPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=JY7zSqNbSr6jHieFGfNBb2BFOOIViCbxvyQkubANxW/qvba5+dFfNk/7E7bAZ5gaWJ
         wx23gZsPk5hH+mRa6u1gaCfD19bssukm/ltc6wsfFs4HZdYVyyUaYOwMSufTyKm2D99U
         R6dvXzIdvCuKZO8dEchU4hLGnk6zHHrKsx7XM=
Received: by 10.223.5.89 with SMTP id 25mr7506898fau.87.1275419233858;
        Tue, 01 Jun 2010 12:07:13 -0700 (PDT)
Received: from [192.168.2.50] (host-83.2.142.85.tvksmp.pl [83.2.142.85])
        by mx.google.com with ESMTPS id 13sm48400021fad.7.2010.06.01.12.07.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 12:07:13 -0700 (PDT)
Message-ID: <4C055A60.3000203@gmail.com>
Date:   Tue, 01 Jun 2010 21:07:12 +0200
From:   =?UTF-8?B?SXJlbmV1c3ogU3pjemXFm25pYWs=?= 
        <irek.szczesniak@gmail.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: MIPS 24Kc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 26971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: irek.szczesniak@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 615

Hi,

I'm writing to inquire about the status of the support for MIPS 24Kc.

I have a RouterBOARD 433 that has the Atheros AR7130 processor with 
the MIPS 24Kc core.  I would like to compile my kernel with the KGDB 
enabled, so that I can debug the kernel on the live hardware.


Thanks,
Irek

-- 
Ireneusz (Irek) Szczesniak
http://www.irkos.org
