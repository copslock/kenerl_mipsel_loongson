Received:  by oss.sgi.com id <S554002AbRBVCgj>;
	Wed, 21 Feb 2001 18:36:39 -0800
Received: from [203.101.127.117] ([203.101.127.117]:43400 "EHLO eris.xware.cx")
	by oss.sgi.com with ESMTP id <S553998AbRBVCg3>;
	Wed, 21 Feb 2001 18:36:29 -0800
Received: (from chris@localhost)
	by eris.xware.cx (8.11.0/8.11.0) id f1M2a2A24908;
	Thu, 22 Feb 2001 13:36:02 +1100
Date:   Thu, 22 Feb 2001 13:36:02 +1100
From:   Crossfire <xfire@xware.cx>
To:     kjlin <kj.lin@viditec-netmedia.com.tw>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Does linux support for microprocessor without MMU?
Message-ID: <20010222133602.A24899@eris.xware.cx>
References: <00ba01c09c6e$84788380$056aaac0@kjlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00ba01c09c6e$84788380$056aaac0@kjlin>; from kj.lin@viditec-netmedia.com.tw on Thu, Feb 22, 2001 at 09:26:44AM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

kjlin was once rumoured to have said:
> Howdy,
> 
> I got an embedded MIPS board recently.
> It has the following features:
> - CPU implements a five-stage pipeline with performance similar to the MIPS R3000 pipeline.
> - MIPS32 compatible instruction set
> - R4000 style privileged resource architecture.
> - Without MMU.
> 
> I am estimating the possibility of porting linux on it.
> Can Linux/MIPS 2.2 or 2.4 support for such a board which without MMU ?
> Because i consider it is the most difficult part in the porting process.
> Am i right?

the Standard Linux kernels all require an MMU.  However, there is a
version of the kernel known as "ucLinux" (Microcontroller Linux) which
will run on CPUs without MMU.

I don't know if ucLinux has a MIPS target yet.

C.
-- 
--==============================================--
  Crossfire      | This email was brought to you
  xfire@xware.cx | on 100% Recycled Electrons
--==============================================--
