Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAS29RP06988
	for linux-mips-outgoing; Tue, 27 Nov 2001 18:09:27 -0800
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAS29Bo06978;
	Tue, 27 Nov 2001 18:09:11 -0800
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id fAS195u17289;
	Tue, 27 Nov 2001 17:09:05 -0800
Received: from exceed2.sanera.net (exceed2.sanera.net [172.16.2.39])
	by icarus.sanera.net (8.11.6/8.11.6) with ESMTP id fAS190D02504;
	Tue, 27 Nov 2001 17:09:00 -0800
Received: from exceed2.sanera.net (exceed2.sanera.net [172.16.2.39])
	by exceed2.sanera.net (8.9.3+Sun/8.9.3) with SMTP id RAA17976;
	Tue, 27 Nov 2001 17:09:00 -0800 (PST)
Message-Id: <200111280109.RAA17976@exceed2.sanera.net>
Date: Tue, 27 Nov 2001 17:09:00 -0800 (PST)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: Memory leaks in SMP MIPS linux 2.4.9?
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: iJGi9Z33rR7kR0SiCO2dGg==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I suspect that there are some memory leaks in the SMP MIPS linux 2.4.9.
I would like to know if any one found the root cause and fixed them.
Here is the description of the memory leak that I am seeing-


1. Summary:
	Memory leaks in Linux 2.4.9 MIPS SMP kernel

2. Description:
	I see that MemFree, as reported by /proc/meminfo, goes down when
	I run the following script.
	
	while true
	do
		date
		cat /proc/meminfo
		cat /proc/slabinfo
	done
	
	MemFree goes down continuously when this script is run.
	When I ran this script for 3-4 days, the MemFree went down
	to 10% of MemTotal!
	
	I just ran the script for 3 hours are here is the diff between
	the out put of /proc/meminfo and /proc/slabinfo before and
	after the test run ( lines with "<" are before the test and
	lines with ">" are after the test)

< Mem:  259584000 15634432 243949568        0  8388608  3756032
---
> Mem:  259584000 28954624 230629376        0  8388608  3756032
6c6
< MemFree:        238232 kB
---
> MemFree:        225224 kB
14c14
< Inact_target:      140 kB
---
> Inact_target:        4 kB
18c18
< LowFree:        238232 kB
---
> LowFree:        225224 kB
41c41
< sigqueue              29     29    132    1    1    1 :  252  126
---
> sigqueue             261    261    132    9    9    1 :  252  126
45,46c45,46
< inode_cache           88     88    480   11   11    1 :  124   62
< dentry_cache         180    180    128    6    6    1 :  252  126
---
> inode_cache          216    216    480   27   27    1 :  124   62
> dentry_cache         420    420    128   14   14    1 :  252  126
50,53c50,53
< mm_struct             48     48    160    2    2    1 :  252  126
< vm_area_struct       177    177     64    3    3    1 :  252  126
< fs_cache             118    118     64    2    2    1 :  252  126
< files_cache           18     18    416    2    2    1 :  124   62
---
> mm_struct            138    264    160    6   11    1 :  252  126
> vm_area_struct       354    354     64    6    6    1 :  252  126
> fs_cache             169    295     64    4    5    1 :  252  126
> files_cache          135    135    416   15   15    1 :  124   62
70c70
< size-1024             88     88   1024   22   22    1 :  124   62
---
> size-1024            208    208   1024   52   52    1 :  124   62
80c80
< size-32              226    226     32    2    2    1 :  252  126
---
> size-32              339    339     32    3    3    1 :  252  126


3. Keywords
	mips, SMP, memory leak

4. Kernel version
	Linux version 2.4.9
	
5. Output
        (included as part of description)

6. testcase
        (included as part of description)

7. Environment
        7.1 software
                None
        7.2 Processor info
                (NOTE *** cat /proc/cpuinfo does not print information about
                    both the CPUs ***)
                cpu                     : MIPS
                processor               : 0
                cpu model               : SiByte SB1 V0.1
                BogoMIPS                : 332.59
                processor               : 1
                cpu model               : SiByte SB1 V0.1
                BogoMIPS                : 332.59
                system type             : SiByte unknown
                byteorder               : big endian
                unaligned accesses      : 0
                wait instruction        : no
                microsecond timers      : no
                extra interrupt vector  : yes
                hardware watchpoint     : no
                VCED exceptions         : not available
                VCEI exceptions         : not available
        7.3 Module information
                No modules.
        7.4 Loaded driver and hardware information (/proc/ioports, /proc/iomem)

                bash-2.04# cat /proc/ioports
                bash-2.04# cat /proc/iomem
                00000000-0fe94fff : System RAM
                  00100000-00267d77 : Kernel code
                  00299a40-002ad38f : Kernel data
        7.5 PCI information
                No PCI devices attached
        7.6 SCSI information
                No SCSI devices attached
        7.7 Other information
		Single user system with no networking.
		Root file system is in the ramdisk.


8. Notes
	
	When I did some investigation, it looked like d_lookup() is
	not finding /proc/meminfo and /proc/slabinfo in the dcache and
	it is doing d_alloc() to add these to the cache every time
	cat /proc/meminfo or cat /proc/slabinfo is done. This looked odd
	and I ran the same script on x86 based linux (running 2.4.2) and
	I did not see MemFree (or any other caches) changing after the
	test was run for an hour. I am not sure how this is architecture
	dependent.

Thanks
Krishna Kondaka
Sanera Systems
