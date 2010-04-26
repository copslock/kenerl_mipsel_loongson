Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 15:41:18 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.148]:14679 "EHLO
        ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491062Ab0DZNlN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Apr 2010 15:41:13 +0200
Received: by ey-out-1920.google.com with SMTP id 3so825659eyh.52
        for <linux-mips@linux-mips.org>; Mon, 26 Apr 2010 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=mGUFQVYWfJK4Q24pWPGaEp/RtnD4yvdMq2GbQhDZs1E=;
        b=ngO9Ov/zvKdz/utW4Ddjca6XP8VgIRSg36Kwn7XrLAbOYvXtANgLfSGNJ+1QkzROp1
         qM8/kVgkFRL+WAw0nufD2ia2baEUvOcAJ1zKtBScBXImXQ1cZ7/skknCY/TCMes6Q36R
         6U4YO7rpUqOJRfSmZ/BjBsLuRmi8Ehx/4Unls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=sil/WBWL7inDtgzqDTCXFq+DiR1AfJuKQvC2Z/Uez8h32dhO808kW2eoMmth26OugZ
         W3GPDADReyReUVqmRP7tcucWM9irUNdFOVLhTPZqMUWmaRDGYgbWJ7GTvjiCFx8q388A
         fuCtXFvMlPm9Wwf519V1CFai7vTV8SBQ+GZdk=
Received: by 10.103.7.26 with SMTP id k26mr2312886mui.15.1272289272186; Mon, 
        26 Apr 2010 06:41:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.177.13 with HTTP; Mon, 26 Apr 2010 06:40:52 -0700 (PDT)
From:   "Giant Sand Fan's" <rampxxxx@gmail.com>
Date:   Mon, 26 Apr 2010 15:40:52 +0200
Message-ID: <l2p417f50831004260640o684d0f8fgf6a3aa60450e329c@mail.gmail.com>
Subject: Cavium mips64 perf counters
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <rampxxxx@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rampxxxx@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to calculate de CPU load by access the performance counters
in mips and I haved reading in the cp0 but my problem is that I cannot
find documentation about the real meaning of these counters :

1.-LOG_PERF_CNT_NISSUE : ¿means cycle with no issue?

2.-LOG_PERF_CNT_SISSUE : ¿means cycle with     issue?

3.-LOG_PERF_CNT_DISSUE: ¿means cycle with double issue?


so CPU load will be == 2*100/(1+2) , in the period of time.

any clue...



thanks

--
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html
