Received:  by oss.sgi.com id <S553856AbQJ3OTN>;
	Mon, 30 Oct 2000 06:19:13 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:42509 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553791AbQJ3OSw>;
	Mon, 30 Oct 2000 06:18:52 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A89A2A36; Mon, 30 Oct 2000 15:18:50 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id BDB5A900C; Mon, 30 Oct 2000 15:17:36 +0100 (CET)
Date:   Mon, 30 Oct 2000 15:17:36 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: userspace spinlocks
Message-ID: <20001030151736.C2687@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
while compiling db2 i got the configure warning "spinlocks not implemented
for this compiler/architecture" - I guess as we do not currently have
SMP machines (except the ones ralf is working on) we dont have a problem,
but how should the spinlocks be implemented ?

I mean - normally "ll" and "sc" are needed - But those are not
available on R3000 - And spinning in an ll/sc loop and emulating
them with exceptions isnt that fast.

OTOH - Where are they normally implemented ? libc ? macro ? Could
there be a runtime linking thing with a cpu detection wether we 
have ll/sc or not ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
