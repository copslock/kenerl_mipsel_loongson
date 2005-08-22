Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2005 22:46:11 +0100 (BST)
Received: from web42206.mail.yahoo.com ([IPv6:::ffff:66.218.93.207]:41657 "HELO
	web42206.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225364AbVHVVpu>; Mon, 22 Aug 2005 22:45:50 +0100
Received: (qmail 19804 invoked by uid 60001); 22 Aug 2005 21:51:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EtypWN5Bsb46cKMDIN2gon3hE17nKe7K7uoNDNSsITN17YWV/klj7zYxnVeWdPf80WUarUIisVVWADW/DYS/b52s+hZfdANqLncU2kx5/gmd23SNT45dTtKlz+QmldUS/R3a71CdoebvDGeYzQQRhNBZ7XM0UTiY7A55XNIjSJY=  ;
Message-ID: <20050822215104.19802.qmail@web42206.mail.yahoo.com>
Received: from [134.244.53.32] by web42206.mail.yahoo.com via HTTP; Mon, 22 Aug 2005 14:51:04 PDT
Date:	Mon, 22 Aug 2005 14:51:04 -0700 (PDT)
From:	Vilas Tharakan <vilas_tharakan@yahoo.com>
Subject: ERROR regarding undefined reference to `__rpc_thread_svc_fdset'
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-583335098-1124747464=:16246"
Content-Transfer-Encoding: 8bit
Return-Path: <vilas_tharakan@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vilas_tharakan@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-583335098-1124747464=:16246
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
I am able to build my object files and the shared library fine (libpublication.so in my case).
when i try to link my executeable against the library libpublication.so, i am getting undefined reference to `__rpc_thread_svc_fdset' error.
One noticeable thing is when i do a nm on libpublication.so, i get the function name
`__rpc_thread_svc_fdset' as __rpc_thread_svc_fdset@@GLIBC_2.2.5
DO any know how can i resolve this issue.
regards
vilas
 

		
---------------------------------
 Start your day with Yahoo! - make it your home page 
--0-583335098-1124747464=:16246
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi,</DIV>
<DIV>I am able to build my object files and the shared library fine (libpublication.so in my case).</DIV>
<DIV>when i try to link my executeable against the library libpublication.so, i am getting undefined reference to `__rpc_thread_svc_fdset' error.</DIV>
<DIV>One noticeable thing is when i do a nm on libpublication.so, i get the function name</DIV>
<DIV>`__rpc_thread_svc_fdset' as <A href="mailto:__rpc_thread_svc_fdset@@GLIBC_2.2.5">__rpc_thread_svc_fdset@@GLIBC_2.2.5</A></DIV>
<DIV>DO any know how can i resolve this issue.</DIV>
<DIV>regards</DIV>
<DIV>vilas</DIV>
<DIV>&nbsp;</DIV><p>
		<hr size=1> <a href="http://us.rd.yahoo.com/evt=34442/*http://www.yahoo.com/r/hs">Start your day with Yahoo! - make it your home page </a>
--0-583335098-1124747464=:16246--
