Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Feb 2007 09:33:01 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.189]:5282 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038409AbXBCJc5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Feb 2007 09:32:57 +0000
Received: by nf-out-0910.google.com with SMTP id l24so1377436nfc
        for <linux-mips@linux-mips.org>; Sat, 03 Feb 2007 01:31:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EKNex/PC8bxEjq6DWlqPDBQhNuyI84nHIOt62PDYrcqVw+2Ta+z2J7EuJIt+OKKBnyzxH0RtoHS8TI/k2oN9hB5kxEiBj/kZhLU05ZE3uBCuBIdJ43yINEPBWLmv6f302zLhKnag412f4/J1HQh0ISe9ikUL3C+Zc5PFwYCPWHc=
Received: by 10.82.152.16 with SMTP id z16mr1506124bud.1170495116407;
        Sat, 03 Feb 2007 01:31:56 -0800 (PST)
Received: by 10.82.178.4 with HTTP; Sat, 3 Feb 2007 01:31:56 -0800 (PST)
Message-ID: <50c9a2250702030131x7ea1331ay29acdd1190208173@mail.gmail.com>
Date:	Sat, 3 Feb 2007 17:31:56 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: whatis the connection with sysctl and "bad magic number for tty struct ..." ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

hi all:
       i am working on a mips borad with linux-2.6.14.
and my board boot up from an initrd and then switch to Nand FLASH as root dev.
it also add a power control entry like the /arch/mips/common/power.c
do. as follow

#define	CTL_ACPI 9999
#define	ACPI_S1_SLP_TYP 19
#define	ACPI_SLEEP 21

static struct ctl_table pm_table[] = {
	{ACPI_S1_SLP_TYP, "suspend", NULL, 0, 0600, NULL, &pm_do_suspend},
	{ACPI_SLEEP, "sleep", NULL, 0, 0600, NULL, &pm_do_sleep},
	{CTL_ACPI, "freq", NULL, 0, 0600, NULL, &pm_do_freq},
	{0}
};

static struct ctl_table pm_dir_table[] = {
	{CTL_ACPI, "pm", NULL, 0, 0555, pm_table},
	{0}
};

/*
 * Initialize power interface
 */
static int __init pm_init(void)
{
	register_sysctl_table(pm_dir_table, 1);
	return 0;
}

__initcall(pm_init);


they had worked well before. but this week, out nand flash driver
change the driver to new code. and when use the same kernel to bootup
,when switch rootfs by /linuxrc. it
get messages "bad magic number for tty struct ..." . but if i manual
insmod my flash driiver, it works.and also if ii remove the
"register_sysctl_table(pm_dir_table, 1)", it works too.

so what will cause this situation? (i have check the flash driver
code, not find special code).

BTW: the initrd is made with busybox instead of nash.


thanks for any hints


Best Regards

zhuzhenhua
