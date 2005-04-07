Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 19:23:34 +0100 (BST)
Received: from web40910.mail.yahoo.com ([IPv6:::ffff:66.218.78.207]:34351 "HELO
	web40910.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225281AbVDGSXT>; Thu, 7 Apr 2005 19:23:19 +0100
Received: (qmail 25260 invoked by uid 60001); 7 Apr 2005 18:23:10 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=HhF0yKMdhGLroA3NvgUkMZZkOXFMfKGSaiTgJZOe8QYKS3UVXg3NSBEYOvQEwzlRqQukjF0i2rtaZoTC4VU3sbxCMh6Wegjn9ahO0rUXMA7SLc9x5+UyQZMWETcGpKzZv4+bUD7uXv7cLDxHehcSqKsqr3zM2d8mjYtxZyF2wbg=  ;
Message-ID: <20050407182310.25258.qmail@web40910.mail.yahoo.com>
Received: from [65.205.244.66] by web40910.mail.yahoo.com via HTTP; Thu, 07 Apr 2005 11:23:10 PDT
Date:	Thu, 7 Apr 2005 11:23:10 -0700 (PDT)
From:	Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: gdb backtrace with core files
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <bkuschak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bkuschak@yahoo.com
Precedence: bulk
X-list: linux-mips

No luck with latest CVS version (GNU gdb
6.3.0.20050407-cvs):

(gdb) bt
warning: GDB can't find the start of the function at
0x658.
 
    GDB is unable to find the start of the function at
0x658
and thus can't determine the size of that function's
stack frame.
This means that GDB may be unable to access that stack
frame, or
the frames below it.
    This problem is most likely caused by an invalid
program counter or
stack pointer.
    However, if you think GDB should simply search
farther back
from 0x658 for code which looks like the beginning of
a
function, you can increase the range of the search
using the `set
heuristic-fence-post' command.
warning: GDB can't find the start of the function at
0x658.
Previous frame identical to this frame (corrupt
stack?)
(gdb) t
[Current thread is 1 (process 362)]
(gdb) bt
#0  0x00000658 in ?? ()
#1  0x00000658 in ?? ()
(gdb) info registers
          zero       at       v0       v1       a0    
  a1       a2       a3
 R0   00000000 2ab01970 00000000 00000338 00000000
00000000 00000000 00000db0
            t0       t1       t2       t3       t4    
  t5       t6       t7
 R8   0dafd6e5 00000001 2abccfd4 2abc8034 00000001
2aac2948 00000001 2abe0ce4
            s0       s1       s2       s3       s4    
  s5       s6       s7
 R16  00400f70 7fff7e74 00400ed0 00000001 00400c70
00000000 10010f80 00000000
            t8       t9       k0       k1       gp    
  sp       s8       ra
 R24  00000263 2ad2c788 2af318b5 00000000 2af8dab0
7fff7bf0 7fff7bf0 2abe0ce4
            sr       lo       hi      bad    cause    
  pc
      00800008 00108413 0001b4e9 800649b8 2ad2c7c8
00000658
           fsr      fir
      00000000 00000000
(gdb)

Regards,
Brian

--- Daniel Jacobowitz <dan@debian.org> wrote:
> On Thu, Apr 07, 2005 at 10:44:54AM -0700, Brian
> Kuschak wrote:
> > Is anyone succesfully using gdb for mipsel to
> debug
> > core dumps?  If so, can you share your secrets for
> > success?  I tried various recent versions (6.3,
> > 6.1.1), but backtrace never works right, even
> though
> > the stack pointer appears to be valid.  gdb-5.3
> > partially works, but not completely.  
> 
> Give the CVS version a try, please.
> 
> -- 
> Daniel Jacobowitz
> CodeSourcery, LLC
> 
> 


		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 
