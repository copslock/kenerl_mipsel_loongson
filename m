Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f97HCqF22369
	for linux-mips-outgoing; Sun, 7 Oct 2001 10:12:52 -0700
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f97HCiD22365;
	Sun, 7 Oct 2001 10:12:44 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id KAA11810;
	Sun, 7 Oct 2001 10:03:47 -0700
Date: Sun, 7 Oct 2001 10:03:47 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: jim@jtan.com, "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: test machines; illegal instructions
Message-ID: <20011007100347.A11796@mvista.com>
References: <20010926221223.A17628@neurosis.mit.edu> <20010926202610.B7962@lucon.org> <20011004011632.A19472@neurosis.mit.edu> <3BBDF25F.1A0F2283@mvista.com> <20011007033910.C4228@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011007033910.C4228@dea.linux-mips.net>; from ralf@oss.sgi.com on Sun, Oct 07, 2001 at 03:39:10AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 07, 2001 at 03:39:10AM +0200, Ralf Baechle wrote:
> On Fri, Oct 05, 2001 at 10:48:15AM -0700, Jun Sun wrote:
> 
> > If your cpu does not have ll/sc instruction, you might be suffering the famous
> > sysmips() problem.  The latest kernel should get you going.
> > 
> > There is also FPU emulation bug which may cause this problem, but that only
> > happens on heavy context switches and FPU usages.
> 
> I've checked in a major bundle of FPU emu fixes last week.  The kernel
> fp code should now produce accurate results and handle exceptions and
> the Flush to Zero bit as per spec.
> 

This particular problem seems still there.  Anybody can try the following
test program on a CPU *without* fpu.

Jun


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kfpe_chk3.c"


/* mipel-linux-gcc -O -o kfpe_chk3 kfpe_chk3.c */

#include <stdio.h>
#include <math.h>
#include <signal.h>
#include <sys/time.h>


double count;
int dummy;
struct itimerval ival;
int icnt=0;

static void alarm_sig_handler(int signum)
{
    int i,j;
    double d;

    if( icnt++ > 500 ){
	icnt = 0;
	/*	printf("count = %f\n", count);*/
    }
    for( i = 0, d = 0.0; d < 1.0; i++, d+=0.1 ){
	count = d;
    }
    setitimer(ITIMER_REAL, &ival, NULL);
    //    alarm(1);
}

int main()
{
    int i,j;
    double d;
    signal(SIGALRM, alarm_sig_handler);

    ival.it_interval.tv_sec = 0;
    ival.it_interval.tv_usec = 0;
    ival.it_value.tv_sec = 0;
    ival.it_value.tv_usec = 10000;
    setitimer(ITIMER_REAL, &ival, NULL);
    //    alarm(1);
    for(;;){
	for( i = 0, d = 0.0; d < 10000.0; i++, d+=0.1 ){
	    count = d;
	}
	signal(SIGALRM, alarm_sig_handler);
    }
    return 0;
}

--0F1p//8PRICkK4MW--
