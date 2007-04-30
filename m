Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2007 20:15:02 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:63590 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022572AbXD3TO7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Apr 2007 20:14:59 +0100
Received: by ug-out-1314.google.com with SMTP id 40so1103023uga
        for <linux-mips@linux-mips.org>; Mon, 30 Apr 2007 12:13:59 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lSazpESEM4XD+S3s5xHy9Ai71Z+GXD4N8bzRPVzo84NflziJCfbsKxSvJpmjjwBO4drib+vJE5QK/OkryIawAvu86cgj0BbJ8FeMQf28dICV1Jmft+a+I/6jxaPqbm1KYQPwJSG31FDkcXXAltPP7DrE6+KE+HRmtN2knFHpKqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aSdRE4hIRb3c3eZt+WyGw/mnLkb/uyu7YcV4nB79Ob0bWchKKbe0ToeXP/XtEBETMxf9amCZ+LgdagzT6EK8dKOST2OW8Joa7oTHUwgkaVrZGm1+WBedwy3ESDAtRII4OWXXOo10pqQW77EMdl7qPM8SmE+Ggpccp8elAEIU/4I=
Received: by 10.82.191.3 with SMTP id o3mr12621342buf.1177960438553;
        Mon, 30 Apr 2007 12:13:58 -0700 (PDT)
Received: by 10.82.121.14 with HTTP; Mon, 30 Apr 2007 12:13:58 -0700 (PDT)
Message-ID: <f69849430704301213n35fbe5fcyc45592a5004cd581@mail.gmail.com>
Date:	Mon, 30 Apr 2007 12:13:58 -0700
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: AMD dual core opetron optimization
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,

I'm doing trying to write some optimized code  for AMD dual core
opetron processor.But things are getting no where.I've installed
Fedora 5 with 2.6 series Linux kernel and 4 series GCC

Following are few lines of code which are consuming close to 100
cycles.Yes this is not the forum for such questions but i think people
on linux kernel and GCC are best to answer such type of questions.I'm
realy getting frustated and helpless ,that's why i've put question on
this forum.

/*******************************************/
/* these variables will be used for RDTSC instrucion */
uint64_t before, overhead, clocks;


/*ReadTsc funtion is given below */
before=ReadTsc();
before=ReadTsc();
before=ReadTsc();

overhead=ReadTsc()-before;

printf(" ReadTSC overerhead is %lu ",overhead);


unsigned int test;
unsigned long buffer [128];
buffer[12]=08;
buffer[13]=00;
buffer[23]=06;

/* starting cycles */

before=ReadTsc();

/**************************Start of Targeted code
******************************/

 test= buffer[12] | buffer[13] | buffer[23] ;

 switch( test )

 {

case  12:
                asm(" jmp proc_1");

case  13:
                 asm("jmp proc_2");
case  14:
                 asm("jmp proc_3");
case  15:
                 asm("jmp proc_4");
default :
             asm("jmp proc_5");

}



asm(" proc_5:");

/**************************End of Targeted code ******************************/
           /*current cycles */
           clocks=ReadTsc() ;

         clocks=clocks - before;
         printf("\n cycles consumed %lu \n",clocks - overhead);

/**********************************/

The overhead varies from generally 360  to 395 cycles .Sometimes it
also reduces close to 270 cycles.

Cycles consumed by the targetd code varies from 20 to 100
cycles.Theoratically i thing cycles consumed should be less than
20.Then why so many cycles  ? and the output vary from 20 to 100
cycles .Sometimes it crosses 100 cycles as well.

Sometimes the cycles consumed by targetted code become far less that
the RDTSC instrucion overhead.

Is there better way to write above code.I even used the prefetch
instruction  before the targeted code to make sure that buffer is in
the L1 cache but no success.

The code for ReadTsc() is as follows.Please also tell me if its
correct way to measure cycles .


/*****************************************/

 typedef long long __int64;

 __int64 ReadTSC() {
   int res[2];                              // store 64 bit result here
   #if defined(__GNUC__) && !defined(__INTEL_COMPILER)
   // Inline assembly in AT&T syntax
   #if defined (_LP64)                      // 64 bit mode
      __asm__ __volatile__  (               // serialize (save rbx)
      "xorl %%eax,%%eax \n push %%rbx \n cpuid \n"
       ::: "%rax", "%rcx", "%rdx");
      __asm__ __volatile__  (               // read TSC, store edx:eax in res
      "rdtsc\n"
       : "=a" (res[0]), "=d" (res[1]) );
      __asm__ __volatile__  (               // serialize again
      "xorl %%eax,%%eax \n cpuid \n pop %%rbx \n"
       ::: "%rax", "%rcx", "%rdx");
   #else                                    // 32 bit mode
      __asm__ __volatile__  (               // serialize (save ebx)
      "xorl %%eax,%%eax \n pushl %%ebx \n cpuid \n"
       ::: "%eax", "%ecx", "%edx");
      __asm__ __volatile__  (               // read TSC, store edx:eax in res
      "rdtsc\n"
       : "=a" (res[0]), "=d" (res[1]) );
      __asm__ __volatile__  (               // serialize again
      "xorl %%eax,%%eax \n cpuid \n popl %%ebx \n"
       ::: "%eax", "%ecx", "%edx");
   #endif
   #else
   // Inline assembly in MASM syntax
      __asm {
         xor eax, eax
         cpuid                              // serialize
         rdtsc                              // read TSC
         mov dword ptr res, eax             // store low dword in res[0]
         mov dword ptr res+4, edx           // store high dword in res[1]
         xor eax, eax
         cpuid                              // serialize again
      };
   #endif   // __GNUC__
   return *(__int64*)res;                   // return result
 }


/*****************************************************************/


thanks,
shahzad
