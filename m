Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2011 09:37:12 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:52276 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904685Ab1K1IhH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Nov 2011 09:37:07 +0100
Received: by iapp10 with SMTP id p10so9893999iap.36
        for <linux-mips@linux-mips.org>; Mon, 28 Nov 2011 00:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=SzZO0W/+mSaqlADCsI0D5eAtD/ndTckFGO+kadPcuJ0=;
        b=u9RsydtuEM0U5VdUPY1LNSsA0MHx3pEYCJi5Q8hExtEFJcxVOWxrhSFVrZie3Aq2Ef
         MRANuLP2oqkcKMHhg3S6oSwHgfYkwEnZNOgubrsQrDf/O6NbWxM3fUrMkanJrIzB7/pn
         LQRbfG+t4uUeZmOUcPW2ppniz7cPG37OCtzAg=
Received: by 10.50.173.74 with SMTP id bi10mr53332336igc.4.1322469421380;
        Mon, 28 Nov 2011 00:37:01 -0800 (PST)
Received: from [192.168.100.234] ([220.232.195.198])
        by mx.google.com with ESMTPS id dm1sm72275217igb.6.2011.11.28.00.37.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 00:37:00 -0800 (PST)
Message-ID: <4ED3483E.60204@gmail.com>
Date:   Mon, 28 Nov 2011 16:37:18 +0800
From:   Jacky Lam <lamshuyin@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Using NFS with HIGHMEM support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lamshuyin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22648

Hi,

     I am using mips-linux-3.0.4 with HIGHMEM enabled. Everything is 
working fine, but I find something strange that when I execute a 
statically-linked binary through NFS mounted directory. It will gives me 
an illegal instruction error or  SIGSEGV. If I run it again, the binary 
can run without problem. I have to reboot or drop all the vm cache in 
order to reproduce the error again.

    Also, if I run the binary in harddisk or dynamically link the 
binary, no problem will be found.

     Any suggestion to debug this problem? Thanks.

Jacky
