Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 13:44:50 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:51383 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491996Ab0KVMor (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Nov 2010 13:44:47 +0100
Received: by gwj18 with SMTP id 18so1345763gwj.36
        for <multiple recipients>; Mon, 22 Nov 2010 04:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=bLfoNQXYAQ2t6lO0ial1vV7vRKv4D4nfs2zuJPY8t7o=;
        b=pG9lm+rqr/LFKI6ORt72gcIUZALq7Cg5N9noP+lYIRd2V86kgBADjo0J13HNbGfEzf
         qTWINwK8MAkT255hisgPU28+0ckurP51rkkZQBNdAwzmm6EfkVI3J65GZGXKNB6cWoqu
         TQ52ZxTkVj4Dk+24lBTOrNnqVJvRtvMmVQG5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=iCAtjE7Xthx0eWUj9iLMI+K2m4YhR5HeiMBIZ9ae3Ic3qMqeQVeKLowUMAvW5jaXSd
         C8oOFQrlGyJ/5W93sur6iZo8MsMYEowTcNRRVRu7wG6/LajlVzbHOwXveWAajjtLl8kI
         QoLvjfv8QjE8WLZ1YH+LDTiO8gC6ZcXU9XeOo=
MIME-Version: 1.0
Received: by 10.231.36.197 with SMTP id u5mr6830328ibd.110.1290429880035; Mon,
 22 Nov 2010 04:44:40 -0800 (PST)
Received: by 10.231.170.70 with HTTP; Mon, 22 Nov 2010 04:44:39 -0800 (PST)
In-Reply-To: <4CE1C96F.1030909@caviumnetworks.com>
References: <20101109154055.GD10799@linux-mips.org>
        <1289486855.14828.0@thorin>
        <1289865028.9277.0@thorin>
        <4CE1C96F.1030909@caviumnetworks.com>
Date:   Mon, 22 Nov 2010 13:44:39 +0100
X-Google-Sender-Auth: Vl0YHPd2b8wSUOvN0015_ZD1s3k
Message-ID: <AANLkTin2gwyyf3f4MtoS0uHt7w9-4FzEcJy49fzNgXE4@mail.gmail.com>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
From:   Robert Millan <rmh@gnu.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        wu zhangjin <wuzhangjin@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

> Acked-by: David Daney <ddaney@caviumnetworks.com>

Any news about this one? Is it good already?

-- 
Robert Millan
