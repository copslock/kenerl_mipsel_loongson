Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 14:59:46 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:51141 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491127Ab0JPM7n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Oct 2010 14:59:43 +0200
Received: by qwj8 with SMTP id 8so784074qwj.36
        for <linux-mips@linux-mips.org>; Sat, 16 Oct 2010 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=0WPyZaVJxvzxjmviMf1uq3oWblN5LFLjW91+9UnliC0=;
        b=jsLApLWT1lqlYJiq0+pSVW7vS/EuV8RqpfZW2VkLBgAlpW2gNZybrjhxHbV2aWXSnZ
         IJCOuTkOOcBZezG0xsVCl/GJ0wqmKfsgEK00WDgu5MV/ganrnO+y3jt0HBCRCnTDYzL/
         T2j2+Emc2JMvOv+Iel40OEFurrJ4C0vsu1/kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iO/kAOUDmYCrj1NzgY8ocdOheTGe2xwsAMA08sMm5tR5d2oEru2I7jYhVcT7VKSTjw
         JGjzbSgg9iMhyK5qH1xvEQ8gLtULz/8KNRdgVDMc2MnY5hEUXuhAV7McQFWuH6acu6NS
         2BzBcMni9oNszRFjnAQ8+L6rHd31As7MeegAI=
MIME-Version: 1.0
Received: by 10.229.214.210 with SMTP id hb18mr1823275qcb.68.1287233977720;
 Sat, 16 Oct 2010 05:59:37 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Sat, 16 Oct 2010 05:59:37 -0700 (PDT)
Date:   Sat, 16 Oct 2010 20:59:37 +0800
Message-ID: <AANLkTik4BddKpVm0x4EpCKCdUff0L=XiYRjfhJaPmX23@mail.gmail.com>
Subject: Where is the definition of i_j macro ?
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all

I'm reading build_r4000_tlb_refill_handler , but found   some macro
like i_j , i_beq undefined in  tlbex.c ( grep linux source code )



 Can anyone tell me where  they come from?  Thank you
