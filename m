Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6SFwPI10273
	for linux-mips-outgoing; Sat, 28 Jul 2001 08:58:25 -0700
Received: from trasno.org (congress234.linuxsymposium.org [209.151.18.234])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6SFwLV10267
	for <linux-mips@oss.sgi.com>; Sat, 28 Jul 2001 08:58:21 -0700
Received: by trasno.org (Postfix, from userid 501)
	id A1E535470; Sat, 28 Jul 2001 14:23:44 +0200 (CEST)
To: Jun Sun <jsun@mvista.com>
Cc: Tom Appermont <tea@sonycom.com>, linux-mips@oss.sgi.com
Subject: Re: measuring time intervals in kernel
References: <20010727154030.A10219@sonycom.com> <3B619FBB.C9F53A65@mvista.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3B619FBB.C9F53A65@mvista.com>
Date: 28 Jul 2001 14:23:44 +0200
Message-ID: <m2bsm5gs33.fsf@anano.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> "jun" == Jun Sun <jsun@mvista.com> writes:

Hi

        could you look at this changes, no change in functionality,
        only better readability,

jun> +asmlinkage void inthoff_logentry(unsigned diff)
jun> +{
jun> +	unsigned sampletime = diff / (cpu_khz / 1000);
jun> +
jun> + 	if (sampletime < bucketlog [0][0] )
jun> +		bucketlog[1][0]++;
jun> +        else if (sampletime < bucketlog [0][1] )
jun> +                bucketlog[1][1]++;
jun> +        else if (sampletime < bucketlog [0][2] )
jun> +                bucketlog[1][2]++;
jun> +        else if (sampletime < bucketlog [0][3] )
jun> +                bucketlog[1][3]++;
jun> +        else if (sampletime < bucketlog [0][4] )
jun> +                bucketlog[1][4]++;
jun> +        else if (sampletime < bucketlog [0][5] )
jun> +                bucketlog[1][5]++;
jun> +        else if (sampletime < bucketlog [0][6] )
jun> +                bucketlog[1][6]++;
jun> +        else if (sampletime < bucketlog [0][7] )
jun> +                bucketlog[1][7]++;
jun> +        else if (sampletime < bucketlog [0][8] )
jun> +                bucketlog[1][8]++;
jun> +        else if (sampletime < bucketlog [0][9] )
jun> +                bucketlog[1][9]++;
jun> +        else if (sampletime < bucketlog [0][10] )
jun> +                bucketlog[1][10]++;
jun> +        else if (sampletime < bucketlog [0][11] )
jun> +                bucketlog[1][11]++;
jun> +        else if (sampletime < bucketlog [0][12] )
jun> +                bucketlog[1][12]++;
jun> +        else if (sampletime < bucketlog [0][13] )
jun> +                bucketlog[1][13]++;
jun> +        else if (sampletime < bucketlog [0][14] )
jun> +                bucketlog[1][14]++;
jun> +        else if (sampletime < bucketlog [0][15] )
jun> +                bucketlog[1][15]++;
jun> +        else if (sampletime < bucketlog [0][16] )
jun> +                bucketlog[1][16]++;
jun> +        else if (sampletime < bucketlog [0][17] )
jun> +                bucketlog[1][17]++;
jun> +        else if (sampletime < bucketlog [0][18] )
jun> +                bucketlog[1][18]++;
jun> +        else if (sampletime < bucketlog [0][19] )
jun> +                bucketlog[1][19]++;
jun> +        else if (sampletime < bucketlog [0][20] )
jun> +                bucketlog[1][20]++;
jun> +        else if (sampletime < bucketlog [0][21] )
jun> +                bucketlog[1][21]++;
jun> +        else if (sampletime < bucketlog [0][22] )
jun> +                bucketlog[1][22]++;
jun> +        else if (sampletime < bucketlog [0][23] )
jun> +                bucketlog[1][23]++;
jun> +        else if (sampletime < bucketlog [0][24] )
jun> +                bucketlog[1][24]++;
jun> +        else if (sampletime < bucketlog [0][25] )
jun> +                bucketlog[1][25]++;
jun> +        else if (sampletime < bucketlog [0][26] )
jun> +                bucketlog[1][26]++;
jun> +        else if (sampletime < bucketlog [0][27] )
jun> +                bucketlog[1][27]++;
jun> +        else if (sampletime < bucketlog [0][28] )
jun> +                bucketlog[1][28]++;
jun> +	else 
jun> +		bucketlog[1][29]++;
jun> +
jun> +	total_samples++;
jun> +
jun> +	return;
jun> +}

Any reason for not changing that to something like this? 

asmlinkage void inthoff_logentry(unsigned diff)
{
        unsigned sampletime = diff / (cpu_khz / 1000);
        int i = 0;

        while ((i < BUCKETS-1) && (sampletime >= bucketlog [0][i]))
              i++;
        bucketlog[1][i]++;

        total_samples++;

        return;
}

jun> +struct IntrData intrData = {
jun> +    0,
jun> +    "interrupt latency test for PPC (8 distinctive entries)",
jun> +    0,
jun> +    0,
jun> +    0,
jun> +
jun> +    1,
jun> +    0xffffffff,
jun> +
jun> +    0,
jun> +    0,
jun> +
jun> +    0,
jun> +    0,
jun> +    0,
jun> +    0,
jun> +    0,
jun> +    0,
jun> +    0
jun> +};

struct IntrData intrData = {
       testname: "interrupt latency test for PPC (8 distinctive entries)",
       rangeLow: 1,
       rangeHigh: 0xffffffff,
}
       

jun> + * we do a count only if
jun> + * 1. syncFlag is 1 (a valid cli() was called)
jun> + * 2. breakCount is 0 (no iret is called between cli() and this sti()
jun> + */

Move this commets to their position in the code (not sure what is
better, but /* check 1 */  /* check 2 */ comments are missleading, and
don't show clearly in diffs :(((

jun> +void intr_sti(const char *fname, unsigned lineno)
jun> +{

[...]

jun> +
jun> +    /* check 1*/
here
jun> +    if (intrData.syncFlag != 1) {
jun> +        intrData.syncStiError ++;
jun> +        __intr_sti();
jun> +        return;
jun> +    }
jun> +
jun> +    /* check 2 */
and here
jun> +    if (intrData.breakCount != 0) {
jun> +        intrData.stiBreakError ++;
jun> +        __intr_sti();
jun> +        return;
jun> +    }


I miss read this two tests the first time, how about a change like
that (I assume that the the check with (x & INT_IENABLE) means
interrupts enabled, otherwise change the names of the vars.

jun> +void intr_restore_flags(const char *fname, unsigned lineno, unsigned x)
jun> +{
jun> +    unsigned flag;
          unsigned flag_int_enabled;
          unsigned x_int_enabled;
jun> +
jun> +    /* if we are not logging or we have an error, do nothing */
jun> +    if ((intrData.logFlag == 0) || ( intrData.panicFlag != 0)) {
jun> +        __intr_restore_flags(x);
jun> +        return;
jun> +    }
jun> +
jun> +    __save_flags(flag);

          flag_int_enabled = (flag & INTR_IENABLE) != 0;
          x_int_enabled = (x & INTR_IENABLE) != 0;

jun> +    if (((flag & INTR_IENABLE) == 0)  &&
jun> +        ((x & INTR_IENABLE) != 0) )  {
          if (!flag_int_enabled  && x_int_enabled) {
jun> +        intrData.restoreSti ++;
jun> +        intr_sti(fname, lineno);
jun> +    }
jun> +
jun> +    if ( ((flag & INTR_IENABLE) != 0) &&
jun> +         ((x & INTR_IENABLE) == 0) ) {
          if (flag_int_enabled && !x_int_enabled) {
jun> +        intrData.restoreCli ++;
jun> +        intr_cli(fname, lineno);
jun> +    }
jun> +
jun> +    __intr_restore_flags(x);
jun> +}

/me decides that he has been enough pedantic today.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
