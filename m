Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2010 20:31:19 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:34995 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492317Ab0GZSbP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jul 2010 20:31:15 +0200
Received: by qwe4 with SMTP id 4so298201qwe.36
        for <linux-mips@linux-mips.org>; Mon, 26 Jul 2010 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=SqOvIApdEFknVvfkPQPVdUhAir1PE3eOJjwgIFTeQzg=;
        b=hU4h2GzHSVtLaaSRETmLp75XhQ6O63kMwy42h+X3WvBdODP2yrfm3hPO21si1f2caR
         4WmSZKv9KHDHG+X1g25fLJhinmLrO6jVrj1IFz9HTrxUwEW9z/IAsEbLOXij2d5lM/gs
         Zg0Fkkq85+8ovAR3g510jdjDGtboEmE6iivHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=Ta4fXr9clWMArdy3C6tdE3f161shVswknZIZv1MebD1u0LHMos7i2FnlOmAMYJplW8
         AvTmnYQXUib3/MvwX+4bZnYnRZuDSRLE1JFtnF6MnmBBUrUdZPUB7lU5REzUAnuavhP9
         luSf4/wKkGPTGnruGATZE9aIFG4ExWbb3RkqE=
Received: by 10.224.59.145 with SMTP id l17mr6628560qah.287.1280169068326; 
        Mon, 26 Jul 2010 11:31:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.25.13 with HTTP; Mon, 26 Jul 2010 11:30:48 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 26 Jul 2010 14:30:48 -0400
Message-ID: <AANLkTinJzB_yWW40tsPhE5mp6w_1=RsoLC=h7kYS5bkx@mail.gmail.com>
Subject: Problems with BCM91125E
To:     linux-mips@linux-mips.org
Cc:     Mark E Mason <mason@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
I got a Broadcom BCM91125E, supposedly "Used, system pull tested good."

I checked the manual [0] to verify that all switches were in the
default positions, and they were. I plugged my serial cable in and
turned it on, and it printed

"""
[HELO]
[L1CI]
[L2CI]
[DRAM]
[RAMX]
"""

and then it stops. According to this document [1] 'RAMX' means "Fatal
error. Displayed if there is no RAM in the system" which is
particularly odd as RAM chips are soldiered on the board.

So, I asked the seller how did he test this board, and what were his
results, and he admitted that they didn't test it, saying "I have no
result to show you, this card we pull out from the working system."

Does anyone have any idea what's wrong here or how to fix it?

Thanks,
Matt Turner

[0] http://www.broadcom.com/support/license.php?file=91125E-UM100-R.pdf
[1] www.gandf.info/firmware/sgda/cfe.pdf
