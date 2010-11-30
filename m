Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2010 20:49:26 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:39280 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492861Ab0K3TtV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Nov 2010 20:49:21 +0100
Received: by iwn4 with SMTP id 4so345723iwn.36
        for <multiple recipients>; Tue, 30 Nov 2010 11:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=BV7cLSnvnBGylQdHka2cV73iAdoh4qKIjRSyd2tqPRQ=;
        b=YDrQG05EJjK12OkyrjVnUJ2lSearDBySJf0C8c3T0wiA0gLjITBPnQrjMaDjzxoH84
         s7X7XOdWxKNhJxnQi/lX6PRtTUefM6SOnQLSZU9H1+kbiq06BlYC47NIezooG4/uYg6t
         m4smVBTfI1lQ+dS3jm1g6aufisZlcHy1A3z3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rPwdthfYGOsFGJLX62dO9qZXiT1EGmP+wlhu8HcjKraWQ+40UCeebYv5aFV4LawNLD
         nud4y6pKhmiK81yFo7fx7mS9yahSH9NNkKRMvPFIVxX7voFyQ0KZY8IT5N534CLDZcGG
         PtLkAVK/wuiRpRFKWodgAXEba2Ef04an/SVv0=
MIME-Version: 1.0
Received: by 10.231.34.3 with SMTP id j3mr7794136ibd.100.1291146559212; Tue,
 30 Nov 2010 11:49:19 -0800 (PST)
Received: by 10.231.8.135 with HTTP; Tue, 30 Nov 2010 11:49:19 -0800 (PST)
In-Reply-To: <4CF4CC6B.9090603@paralogos.com>
References: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>
        <20101122034141.GA13138@linux-mips.org>
        <4CEAE1EE.9020406@paralogos.com>
        <AANLkTimuJLxG2KoibRxzcHkX3LoKsTWqJSF_e=ouFi+b@mail.gmail.com>
        <4CEE877C.7020309@paralogos.com>
        <AANLkTinUSjvjwHVJoRW-Fr75WDfheq3hSM_hEBMsEUXK@mail.gmail.com>
        <4CF46741.9060902@paralogos.com>
        <AANLkTikb32T_c7iu6aa0mXDDqC4ncsV9iQAqyVKHy1_y@mail.gmail.com>
        <4CF4CC6B.9090603@paralogos.com>
Date:   Tue, 30 Nov 2010 11:49:19 -0800
Message-ID: <AANLkTinQKfeYockOBYQOasJ0-C3T106Qe95hV23pfqKg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ASID conflict after CPU hotplug
From:   Maksim Rayskiy <maksim.rayskiy@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

