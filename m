Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jun 2013 12:34:44 +0200 (CEST)
Received: from mail-bk0-f44.google.com ([209.85.214.44]:52936 "EHLO
        mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822429Ab3FGKelWt1TO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jun 2013 12:34:41 +0200
Received: by mail-bk0-f44.google.com with SMTP id r7so2195822bkg.31
        for <linux-mips@linux-mips.org>; Fri, 07 Jun 2013 03:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=XspVZBDGXZV45kA5NGxQ2OHhyK/6XgsIlPyC08YVhkA=;
        b=Zc8uWunAxqJB+bIwt1jFlocOcMZEBeqR0rc0eHYL7T/vYmiCIn7/wKb/SEcv/I7KxY
         A0Gk0YsFz1NFh4q+2EQiRc1W5w4Xn+D9xH/bIxyy6iNFPidoM8qt0O9UENJ8cNLFnvSq
         iznA1tCDmm6KVW+ysN43gXYUdHvQzJScjKVAGH12bRTjlJAWknz/dFBHEM+DUbIS+Nrm
         CjssLNzun1erEOqVE0X7WoHkCfQSAfH8pnEIwKaFF0ttF0NHJ1QaQsN8Q6/FylW++ujx
         ++YTFLznNuAejF0VhhKwnmC5QMEv0uCD01nbK5CEAHQuZcRpkA6x+KkpsO/EAuVZIQyl
         ZhWA==
X-Received: by 10.204.232.133 with SMTP id ju5mr3643580bkb.139.1370601275913;
        Fri, 07 Jun 2013 03:34:35 -0700 (PDT)
Received: from [172.16.40.101] (134.117.39.62.rev.sfr.net. [62.39.117.134])
        by mx.google.com with ESMTPSA id b12sm30030995bkz.0.2013.06.07.03.34.34
        for <linux-mips@linux-mips.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 03:34:34 -0700 (PDT)
Message-ID: <51B1B739.7080104@wyplay.com>
Date:   Fri, 07 Jun 2013 12:34:33 +0200
From:   Alexis BRENON <abrenon@wyplay.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Immediate branch offset
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkXAjtLzliSccDYkRRUFkLnyPvl7ekFhyqdGEH1/Gh4snRkLlxYsccsimD26/qDwApqSO65
Return-Path: <abrenon@wyplay.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrenon@wyplay.com
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

Hi everyone,

I'm new on the list, so I'll make a short introduction of me.
First of all, I'm french, so, please, be indulgent for my english 
mistakes...
I'm working on the Pypy project, to create a MIPS backend (a MIPS JIT).

To create the JIT, I have to load some MIPS instruction directly in 
memory without passing through a .asm file or else. So, I cannot set 
some labels. So to make some branches, I try to load the equivalent 
instruction of :
     bne $t0, $t1, -8
to go back, just before the bne instruction, if $t0 and $t1 are equals. 
But when it run, I've got an illegal instruction error.
To debug, I write a small program in the MARS MIPS simulator with this 
instruction. But when compiling, assembler says me that -8 is an operand 
of incorrect type.
I would like to know if it's possible to make a branch, with an 
immediate offset, or have I to always provide a label ?

I hope my question is clear.
Thanks for your attention, and for your answer :-p

Alexis BRENON

P.S. I try to go to the IRC channel, but I receive '#mipslinux :Cannot 
send to channel' every time  I send message. Is there any particular 
process to join the channel ?
