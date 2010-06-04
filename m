Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jun 2010 00:22:47 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:42193 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492570Ab0FDWWo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jun 2010 00:22:44 +0200
Received: by pvg11 with SMTP id 11so298134pvg.36
        for <linux-mips@linux-mips.org>; Fri, 04 Jun 2010 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=BtmlN0yNE3VgWRrldYqZ88uRBtvH+Svqwi6xthZW+t4=;
        b=cwiFCTzYia5D34sSJBYRKEmRpeiCIJWTOQPm/fhKQ1+P/PvdAgjzyhoOf+Rz0fqa0V
         K49Lmc1dvaYfTGcLkyWrn4Xv1fTzIqvuJDkevbXsabXhEhofRakISpSDn9umLLRb5/5S
         c9XubxlFgnWfN228GLhbCfj/CtlI2aN1gagZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=BwFwTlVLE6lN/3GyxEaIkSS/6WO9gLkTNeVFZ+jYyf5w3xFpJmrXraSTXHXpymRYy0
         DIrzzSCSBrCzMpxUvxNnjI2g3tPL8h2k1F38oulUvrfV93NL7IOQsHFm8cD5A+w3lAJy
         aPs7TdevPRc0XazQf77+KdHXXyXXX5H6KzzCs=
MIME-Version: 1.0
Received: by 10.114.253.9 with SMTP id a9mr9094402wai.72.1275690155307; Fri, 
        04 Jun 2010 15:22:35 -0700 (PDT)
Received: by 10.115.32.17 with HTTP; Fri, 4 Jun 2010 15:22:35 -0700 (PDT)
Date:   Sat, 5 Jun 2010 06:22:35 +0800
Message-ID: <AANLkTikRaw_OLR7LenUA8acaedJy2V6HZKJ0cAd6PNRk@mail.gmail.com>
Subject: [Q] MIPS: How to record the user stack backtrace in the kernel
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     dengcheng.zhu@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                
X-UID: 3579

Hi, developers


In the kernel, we don't have frame unwinder to work on the user stack.
Given the different possible compiler flags, getting the backtrace for the
user stack is especially challenging. Certainly, I don't want symbols -
only to get a list of return addresses. Do you have any comments?


Thanks!

Deng-Cheng
