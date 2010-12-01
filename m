Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 09:17:48 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:49444 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491988Ab0LAIRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 09:17:45 +0100
Received: by qwh6 with SMTP id 6so2310154qwh.36
        for <linux-mips@linux-mips.org>; Wed, 01 Dec 2010 00:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=v7/r4UGF58bvsvFq3wORRSkPzm7Sidw3kMEdIeDnXJY=;
        b=dGw78CHI4cxaXV9mBiIuHx/mDc+Fw8/uK4V29jPW0owlODKCkvD07f2LnTZaMdd1MA
         1pl2KWRsrX5C4pojpsHPPlz+vSdJgHzpq1G50oEFLXhsBYnjsDEkpS5tPcTYDuhYW6Rh
         J0deqMllfr6xzcZcJuE4oplkELNs0/ajiUVw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xRwMGvfuP2qAgQu2TeEkpIc7TcVPjjlNwoNb0Du/oPONVFYae8+evwVgaXLFGFuzWr
         wCFfkrBfHJ352ISZhygWqZiaNu8SUgKNtv3uUoM0sM3xejz3eI7a2yCW/PiRdjocmtke
         SFhdJuPeagcbRuLoB0oAQqWtxEePV9B9Lx1eo=
MIME-Version: 1.0
Received: by 10.229.238.16 with SMTP id kq16mr6959720qcb.134.1291191458928;
 Wed, 01 Dec 2010 00:17:38 -0800 (PST)
Received: by 10.229.96.148 with HTTP; Wed, 1 Dec 2010 00:17:38 -0800 (PST)
Date:   Wed, 1 Dec 2010 13:47:38 +0530
Message-ID: <AANLkTinZytSf5izqEuK5ACQzfDn-P-qmjr6HEet35k1-@mail.gmail.com>
Subject: double kfree
From:   naveen yadav <yad.naveen@gmail.com>
To:     kernelnewbies@nl.linux.org, linux-mips@linux-mips.org,
        linux-arm-kernel-request@lists.arm.linux.org.uk
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

I Have following question with regard for 2.6.30 kernel

 If we do double kfree()

a) Then what will happen?
b) Can kernel detect double kfree() ?


I gone through google to find some way to find it, there it mention
CONFIG_DEBUG_SLAB can help, but i am not sure how usefull is it.

I have two targets will it support on both ?


Thanks
